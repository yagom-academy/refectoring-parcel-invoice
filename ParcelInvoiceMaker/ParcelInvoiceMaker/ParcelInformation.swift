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
    private let discount: Discount
    var discountedCost: Int {
        discount.strategy.applyDiscount(deliveryCost: deliveryCost)
    }
    
    init(receiverInfomation: Receiver.Infomation, deliveryCost: Int, discount: Discount) {
        self.receiverInfomation = receiverInfomation
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}

