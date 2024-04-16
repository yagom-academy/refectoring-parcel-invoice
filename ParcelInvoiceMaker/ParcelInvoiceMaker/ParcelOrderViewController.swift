//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol ParcelOrderProtocol {
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void)
}

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    private var parcelOrderProcessor: ParcelOrderProtocol
    
    init(parcelOrderProcessor: ParcelOrderProtocol = ParcelOrderProcessor(delegate: DatabaseParcelInformationPersistence())){
        self.parcelOrderProcessor = parcelOrderProcessor
        
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "error", message: "error! error!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "confirm", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        parcelOrderProcessor.process(parcelInformation: parcelInformation) { (parcelInformation) in
            let invoiceViewController: InvoiceViewController = .init(parcelInformation: parcelInformation)
            navigationController?.pushViewController(invoiceViewController, animated: true)
        }
    }
    
    override func loadView() {
        view = ParcelOrderView(delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

