//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    
    private let orderProcessor: OrderProcessor
    
    init(orderProcessor: OrderProcessor) {
        self.orderProcessor = orderProcessor
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        orderProcessor.process(parcelInformation: parcelInformation) { [weak self] parcelInformation in
            let invoiceViewController: InvoiceViewController = .init(parcelInformation: parcelInformation)
            self?.navigationController?.pushViewController(invoiceViewController, animated: true)
        }
    }
    
    override func loadView() {
        view = ParcelOrderView(delegate: self)
    }

}

