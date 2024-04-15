//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

struct Address {
    let value: String
}

struct Name {
    let value: String
}

struct Mobile {
    let value: String
}

struct ReceiverInfo {
    let address: Address
    let receiverName: Name
    let receiverMobile: Mobile
}

struct Cost {
    let value: Int
}

//yujeong - MARK: STEP 2-1 Refactoring Code (SOLID OCP / 객체 미용 체조 2원칙 적용)
struct DiscountedCost {
    let value: Int
    private let discount: Discount
    
    //init으로 값을 초기화하여 사용한다 - yujeong
    init(value: Int, discount: Discount) {
        self.value = discount.strategy.applyDiscount(deliveryCost: value)
        self.discount = discount
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

struct CostInfo {
    let deliveryCost: Cost
    let discountedCost: DiscountedCost
}

//yujeong - MARK: STEP 1-1 Refactoring Code (객체미용체조 7원칙)
class ParcelInformation {
    let receiverInfo: ReceiverInfo
    let costInfo: CostInfo
    
    init(receiverInfo: ReceiverInfo, costInfo: CostInfo) {
        self.receiverInfo = receiverInfo
        self.costInfo = costInfo
    }
}

//yujeong - MARK: STEP 1-3 Refactoring Code (SOLID DIP 적용)
protocol ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation)
}

//yujeong - MARK: STEP 1-2 Refactoring Code (SOLID SRP 적용)

/* - yujeong
DatabaseParcelInformationPersistence 에 save 기능을 분리시키고 ParcelOrderProcessor 의 프로퍼티에 의해 메서드를 요청
 -> 그치만 databaseParcelInfoPersistence 프로퍼티를 직접 소유함으로써 의존성을 가지고 있음
 -> STEP 1-3 에서 ParcelInformationPersistence 프로토콜을 채택하도록 수정
*/
class DatabaseParcelInformationPersistence: ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.")
    }
}

class ParcelOrderProcessor: ParcelOrder {
    private let databaseParcelInfoPersistence: ParcelInformationPersistence
    
    init(databaseParcelInfoPersistence: ParcelInformationPersistence) {
        self.databaseParcelInfoPersistence = databaseParcelInfoPersistence
    }
    
    //ParcelOrderViewController에서 ParcelOrderProcessor 를 직접 소유하지 않기 위해 추상화 클래스 ParcelOrder를 활용 - yujeong
    func initProcessor() -> ParcelOrderProcessor {
        return ParcelOrderProcessor(databaseParcelInfoPersistence: self.databaseParcelInfoPersistence)
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {
        
        // 데이터베이스에 주문 저장
        databaseParcelInfoPersistence.save(parcelInformation: parcelInformation)
        
        onComplete(parcelInformation)
    }
}
