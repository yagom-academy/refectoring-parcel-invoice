//
//  ParcelInformation.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/12/24.
//

import Foundation

struct ParcelInformation {
    let receiverInfomation: Receiver.Infomation
    
    private let deliveryCost: Int 
    private let discountType: DiscountType
    private let receiptType: ReceiptType
    
    init(receiverInfomation: Receiver.Infomation,
         deliveryCost: Int,
         discountType: DiscountType,
         receiptType: ReceiptType) {
        self.receiverInfomation = receiverInfomation
        self.deliveryCost = deliveryCost
        self.discountType = discountType
        self.receiptType = receiptType
    }
    
    func getDiscountedCost() -> Int {
        let discounter = Discounter()
        let strategy = discounter.strategy(for: discountType)
        return strategy.applyDiscount(with: deliveryCost)
    }
    
    func getReceiptTitle() -> String {
        return receiptType.title
    }
}

