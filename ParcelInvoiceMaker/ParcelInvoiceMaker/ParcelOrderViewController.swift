//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol ParcelOrderProtocol {
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) throws
}

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    private let parcelOrderProcessor: ParcelOrderProtocol
    private let alertManager: alertManager
    
    init(parcelOrderProcessor: ParcelOrderProtocol, alertManager: alertManager = AlertManager()){
        self.parcelOrderProcessor = parcelOrderProcessor
        self.alertManager = alertManager
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        do {
            try parcelOrderProcessor.process(parcelInformation: parcelInformation) { (parcelInformation) in
                let invoiceViewController: InvoiceViewController = .init(parcelInformation: parcelInformation)
                navigationController?.pushViewController(invoiceViewController, animated: true)
            }
        } catch personValidationError.nameCountLimitError {
            alertManager.showOneButtonAlert(viewController: self, title: "error", message: "name error")
        } catch {
            
        }
        
    }
    
    override func loadView() {
        view = ParcelOrderView(delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

