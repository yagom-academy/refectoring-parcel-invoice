//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    
    private let orderProcessorable: OrderProcessorable
    private let receiptProcessorable: ReceiptProcessorable
    
    init(orderProcessorable: OrderProcessorable,
         receiptProcessorable: ReceiptProcessorable) {
        self.orderProcessorable = orderProcessorable
        self.receiptProcessorable = receiptProcessorable
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        Task { 
            await orderProcessorable.process(parcelInformation: parcelInformation)
            await receiptProcessorable.send(parcelInformation: parcelInformation)
            goToInvoice(parcelInformation: parcelInformation)
        }
    }
    
    override func loadView() {
        view = ParcelOrderView(delegate: self)
    }
    
    private func goToInvoice(parcelInformation: ParcelInformation) {
        let invoiceViewController: InvoiceViewController = .init(parcelInformation: parcelInformation)
        self.navigationController?.pushViewController(invoiceViewController, animated: true)
    }

}

