//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

class ParcelInformation {
    let address: String
    var receiverName: Name
    var receiverMobile: PhoneNumber
    let deliveryCost: Cost
    private let discount: Discount
    var discountedCost: Cost {
        guard let strategy = discount.strategy else { fatalError("strategy is nil") }
        return strategy.applyDiscount(deliveryCost: deliveryCost)
    }

    init(address: String, receiverName: Name, receiverMobile: PhoneNumber, deliveryCost: Cost, discount: Discount) {
        self.address = address
        self.receiverName = receiverName
        self.receiverMobile = receiverMobile
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}

class PhoneNumber {
    private(set) var value: String
    
    init(_ value: String) throws {
        try Self.validate(value)
        self.value = value
    }
    
    private static func validate(_ value: String) throws {
        guard isValidPhoneNumber(value) else { fatalError("phoneNumber is wrong") }
    }
    
    private static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$"
        
        do {
            let regex = try NSRegularExpression(pattern: phoneNumberRegex)
            let matches = regex.matches(in: phoneNumber, range: NSRange(location: 0, length: phoneNumber.count))
            return !matches.isEmpty
        } catch {
            return false
        }
    }
}

class Name {
    private(set) var value: String
    
    init(_ value: String) throws {
        try Self.validate(value)
        self.value = value
    }
    
    private static func validate(_ value: String) throws {
        guard value.count < 1000 else {
            fatalError("name is too long")
        }
    }
}

protocol DiscountStrategy {
    func applyDiscount(deliveryCost: Cost) -> Cost
    func checkDiscount(discount: Discount) -> Bool
}

struct NoDiscountStrategy: DiscountStrategy {
    func checkDiscount(discount: Discount) -> Bool {
        discount == .none
    }
    
    func applyDiscount(deliveryCost: Cost) -> Cost {
        deliveryCost
    }
}

struct VipDiscountStrategy: DiscountStrategy {
    func checkDiscount(discount: Discount) -> Bool {
        discount == .vip
    }
    
    func applyDiscount(deliveryCost: Cost) -> Cost {
        do {
            return try Cost(deliveryCost.value / 5 * 4)
        } catch {
            fatalError("Cost가 음수입니다.")
        }
    }
}

struct CouponDiscountStrategy: DiscountStrategy {
    func checkDiscount(discount: Discount) -> Bool {
        discount == .coupon
    }
    
    func applyDiscount(deliveryCost: Cost) -> Cost {
        do {
            return try Cost(deliveryCost.value / 2)
        } catch {
            fatalError("Cost가 음수입니다.")
        }
    }
}

class Cost {
    private(set) var value: Int
    
    private static func validate(_ value: Int) throws {
        guard value >= 0 && value < .max else {
            throw NSError() as Error
        }
    }
    
    init(_ value: Int) throws {
        try Self.validate(value)
        self.value = value
    }
    
    func setValue(_ value: Int) throws {
        try Self.validate(value)
        self.value = value
    }
}

enum Discount: Int {
    case none = 0, vip, coupon
    
    var strategy: DiscountStrategy? {
        let strategies: [DiscountStrategy] = [NoDiscountStrategy(), VipDiscountStrategy(), CouponDiscountStrategy()]
        
        guard let strategy = strategies.filter({ $0.checkDiscount(discount: self) }).first else {
            fatalError("strategy is not found")
        }
        
        return strategy
    }
}

protocol ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation)
}

class ParcelOrderProcessor: ParcelOrderProcessorProtocol {

    var persistence: ParcelInformationPersistence?
    
    init(persistence: ParcelInformationPersistence? = nil) {
        self.persistence = persistence
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {

        guard let persistence = persistence else {
            fatalError("persistence is nil")
        }
        // 데이터베이스에 주문 저장
        persistence.save(parcelInformation: parcelInformation)
        
        onComplete(parcelInformation)
    }
}

struct DatabaseParcelInformationPersistence: ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.")
    }
}
