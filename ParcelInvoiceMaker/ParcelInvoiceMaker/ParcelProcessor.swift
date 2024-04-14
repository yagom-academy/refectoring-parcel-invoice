//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

struct Address {
    private let address: String
    init(value: String) throws {
        guard !value.isEmpty else {
            throw errorAddress.empty
        }
        self.address = value
    }
    
    func getAddress() -> String {
        return self.address
    }
}

enum errorAddress: Error {
    case empty
}

struct Name {
    private let name: String
    init(value: String) throws {
        guard !value.isEmpty else {
            throw errorName.empty
        }
        self.name = value
    }
    
    func getName() -> String {
        return self.name
    }
}

enum errorName: Error {
    case empty
}

struct Mobile {
    private let mobile: String
    
    init(value: String) throws {
        try Self.validate(value: value)
        self.mobile = value
    }
    
    func getMobile() -> String {
        return self.mobile
    }
    
    private static func validate(value: String) throws {
        guard !value.isEmpty else {
            throw errorMobile.empty
        }
        guard value.count < 13 else {
            throw errorMobile.rangeOver
        }
    }
}

enum errorMobile: Error {
    case empty
    case rangeOver
}

struct Person {
    private let address: Address
    private var name: Name
    private var mobile: Mobile
    
    init(address: Address, name: Name, mobile: Mobile) {
        self.address = address
        self.name = name
        self.mobile = mobile
    }
    
    func getAddress() -> String {
        return self.address.getAddress()
    }
    func getName() -> String {
        return self.name.getName()
    }
    func getMobile() -> String {
        return self.mobile.getMobile()
    }
}

protocol DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int
}

struct NoDiscount: DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int {
        return deliveryCost
    }
}

struct VIPDiscount: DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int {
        return deliveryCost / 5 * 4
    }
}

struct CouponDiscount: DiscountStrategy {
    func applyDiscount(deliveryCost: Int) -> Int {
        return deliveryCost / 2
    }
}

class ParcelInformation {
//    let address: String
//    var receiverName: String
//    var receiverMobile: String
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
    case none = 0, vip = 1, coupon = 2
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

protocol ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation)
}

class ParcelOrderProcessor: ParcelOrderProtocol {
    private var delegate: ParcelInformationPersistence
    
    init(delegate: ParcelInformationPersistence) {
        self.delegate = delegate
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {
        
        // 데이터베이스에 주문 저장
        delegate.save(parcelInformation: parcelInformation)
        
        onComplete(parcelInformation)
    }
}

class DatabaseParcelInformationPersistence: ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.\n\(parcelInformation)")
    }
}
