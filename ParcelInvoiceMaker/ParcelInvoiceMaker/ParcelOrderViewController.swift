//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    private let parcelProcessor: ParcelOrderProcessor = ParcelOrderProcessor()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        parcelProcessor.process(parcelInformation: parcelInformation) { (parcelInformation) in
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

