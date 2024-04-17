//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol ParcelOrder {
    func initProcessor() -> ParcelOrderProcessor
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void)
}

//yujeong - MARK: STEP 1-3 Refactoring Code (SOLID DIP 적용)
//ParcelOrderViewController에서 ParcelOrderProcessor 를 직접 소유하지 않기 위해 추상화 클래스 ParcelOrder를 활용
class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
//    private let parcelProcessor: ParcelOrderProcessor = ParcelOrderProcessor(databaseParcelInfoPersistence: DatabaseParcelInformationPersistence())
    private let parcelProcessor: ParcelOrder
    
    init(parcelProcessor: ParcelOrder) {
        self.parcelProcessor = parcelProcessor
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

}

