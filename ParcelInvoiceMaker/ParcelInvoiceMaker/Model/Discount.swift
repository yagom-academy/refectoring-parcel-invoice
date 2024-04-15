//
//  Discount.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/12/24.
//

import Foundation

enum DiscountType: Int {
    case none, vip, coupon
}

struct Discounter {
    func strategy(for discountType: DiscountType) -> DiscountStrategy {
        switch discountType {
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