//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol ParcelOrderProcessorProtocol {
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void)
}

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    private var parcelProcessor: ParcelOrderProcessorProtocol?
    
    init(parcelProcessor: ParcelOrderProcessorProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        guard let parcelProcessor = parcelProcessor else { fatalError("parcelProcessor is nil") }
        self.parcelProcessor = parcelProcessor
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        parcelProcessor?.process(parcelInformation: parcelInformation) { (parcelInformation) in
            let invoiceViewController: InvoiceViewController = .init(parcelInformation: parcelInformation)
            navigationController?.pushViewController(invoiceViewController, animated: true)
        }
    }
    
    override func loadView() {
        view = ParcelOrderView(delegate: self)
    }

}

