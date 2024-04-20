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
        discount.strategy.applyDiscount(deliveryCost: deliveryCost)
    }
    
    init(receiver: Person, deliveryCost: Int, discount: Discount) {
        self.receiver = receiver
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}

enum Discount: Int {
    case none = 0, vip, coupon
    var strategy: DiscountStrategy {
        switch self {
        case .none:
            return NoDiscount()
        case .vip:
            return VIPDiscount()
        case .coupon:
            return CouponDiscount()
        }
    }
}
