//
//  ParcelInformation.swift
//  ParcelInvoiceMaker
//
//  Created by Eunsung on 4/16/24.
//

import Foundation

class ParcelInformation {
    let receiver: Person
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
    
    init(receiver: Person, deliveryCost: Int, discount: Discount) {
        self.receiver = receiver
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}

enum Discount: Int {
    case none = 0, vip, coupon
}
