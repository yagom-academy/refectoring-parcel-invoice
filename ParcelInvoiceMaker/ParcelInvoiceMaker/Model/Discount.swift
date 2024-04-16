//
//  Discount.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/12/24.
//

import Foundation

enum DiscountType: Int, CaseIterable {
    case none, vip, coupon
    
    var title: String {
        switch self {
        case .none:
            return "없음"
        case .vip:
            return "VIP"
        case .coupon:
            return "쿠폰"
        }
    }
}

enum DiscountRate {
    static let vip: Int = 20
    static let coupon: Int = 2
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
        return deliveryCost / DiscountRate.vip
    }
}

private struct CouponStrategy: DiscountStrategy {
    func applyDiscount(with deliveryCost: Int) -> Int {
        return deliveryCost / DiscountRate.coupon
    }
}
