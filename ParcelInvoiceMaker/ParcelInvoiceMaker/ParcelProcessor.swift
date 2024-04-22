//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import Foundation
protocol DiscountStratege {
    func applyDiscount(deliveryCost: Int) -> Int
}
class NoDiscount: DiscountStratege {
    func applyDiscount(deliveryCost: Int) -> Int {
        return deliveryCost
    }
}
class VIPDiscount: DiscountStratege {
    func applyDiscount(deliveryCost: Int) -> Int {
        return deliveryCost / 5 * 4
    }
}
class CouponDiscount: DiscountStratege {
    func applyDiscount(deliveryCost: Int) -> Int {
        return deliveryCost / 2
    }
}

class ParcelInformation {
    var receiver: ReceiverInformation
    let deliveryCost: Int
    private let discount: Discount
    lazy var discountedCost: Int = discount.strategy.applyDiscount(deliveryCost: deliveryCost)

    init(receiver: ReceiverInformation,
         deliveryCost: Int,
         discount: Discount) {
        self.receiver = receiver
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}

enum Discount: Int {
    case none = 0, vip, coupon
    var strategy: DiscountStratege {
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

struct ReceiverInformation {
    let address: String
    let name: String
    let mobile: String
}
class ParcelOrderProcessor: ParcelOrderProcessorType {
    
    let parcelInformationPersistence: ParcelInformationPersistence
    // 택배 주문 처리 로직
    
    init(databaseParcelInformationPersistence: ParcelInformationPersistence) {
        self.parcelInformationPersistence = databaseParcelInformationPersistence
    }
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {
        
        // 데이터베이스에 주문 저장
        parcelInformationPersistence.save(parcelInformation: parcelInformation)
        onComplete(parcelInformation)
    }
    

}

class DatabaseParcelInformationPersistence: ParcelInformationPersistence {
    
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.")
    }
}

protocol ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation)
}


protocol ParcelOrderProcessorType {
    var parcelInformationPersistence: ParcelInformationPersistence { get }
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void)
}
