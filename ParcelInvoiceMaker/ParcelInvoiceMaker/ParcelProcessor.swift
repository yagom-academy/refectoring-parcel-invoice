//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

class ParcelInformation {
    let receiverInfomation: Receiver.Infomation
    
    let deliveryCost: Int
    private let discount: Discount
    var discountedCost: Int {
        switch discount {
        case .none:
            return deliveryCost
        case .vip:
            return deliveryCost / 5 * 4
        case .coupon:
            return deliveryCost / 2
        }
    }

    
    init(receiverInfomation: Receiver.Infomation, deliveryCost: Int, discount: Discount) {
        self.receiverInfomation = receiverInfomation
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}


enum Discount: Int {
    case none = 0, vip, coupon
}

protocol OrderProcessor {
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void)
}

class ParcelOrderProcessor: OrderProcessor {
    
    private let parcelInformationPersistence: ParcelInformationPersistable
    
    init(parcelInformationPersistence: ParcelInformationPersistable) {
        self.parcelInformationPersistence = parcelInformationPersistence
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {
        
        parcelInformationPersistence.save(parcelInformation: parcelInformation) {
            onComplete(parcelInformation)
        }
    }

}
