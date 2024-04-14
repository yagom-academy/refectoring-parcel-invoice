//
//  Discount.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/12/24.
//

import Foundation

enum Discount: Int {
    case none, vip, coupon
    var strategy: DiscountStrategy {
        switch self {
        case .none:
            NoneDiscountStrategy()
        case .vip:
            VipStrategy()
        case .coupon:
            CouponStrategy()
        }
    }
}

protocol DiscountStrategy {
    func applyDiscount(with deliveryCost: Int) -> Int
}

private struct NoneDiscountStrategy: DiscountStrategy {
    func applyDiscount(with deliveryCost: Int) -> Int {
        return deliveryCost
    }
}

private struct VipStrategy: DiscountStrategy {
    func applyDiscount(with deliveryCost: Int) -> Int {
        return deliveryCost / 5 * 4
    }
}

private struct CouponStrategy: DiscountStrategy {
    func applyDiscount(with deliveryCost: Int) -> Int {
        return deliveryCost / 2
    }
}
