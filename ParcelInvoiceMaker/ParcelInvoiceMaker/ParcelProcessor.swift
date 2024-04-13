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

class ParcelInformation {
//    let address: String
//    var receiverName: String
//    var receiverMobile: String
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

class ParcelOrderProcessor {
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {
        
        // 데이터베이스에 주문 저장
        save(parcelInformation: parcelInformation)
        
        onComplete(parcelInformation)
    }
    
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.")
    }
}
