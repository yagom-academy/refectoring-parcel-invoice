//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

/**
 * 1. 객체미용체조 7원칙 '2개 이상의 원시타입 프로퍼티를 갖는 타입 금지'
 *  - 묶어낼 수 있는 프로퍼티 묶어서 새로운 타입으로 분리하기
 * 2. SOLID SRP 적용
 *  - DB저장 기능을 다른 타입으로 하기 - DatabaseParcelInformationPersistence
 *  - DatabaseParcelInformationPersistence는 ParcelOrderProcessor 프로퍼티가 될 것
 *  - ParcelOrderProcessor는 process 중 DatabaseParcelInformationPersistence에 저장 요청할 것
 * 3. SOLID DIP 적용
 *  - ParcelOrderProcessor와 DatabaseParcelInformationPersistence의 의존성 분리하기
 *    - ParcelInformationPersistence 프로토콜 이용
 *  - ParcelOrderProcessor는 ParcelInformationPersistence를 의존하도록 변경하고 init 시점에 DatabaseParcelInformationPersistence 인스턴스를 생성할것
 *  - ParcelOrderViewController의 의존성 역전을 고민해볼것.
 */

//S: 객체미용원칙 3원칙에 따라 각각의 값은 별도의 양식대로 값이 들어왔는지를 검증하여 처리해야한다.
//Swift는 class, struct, enum 인스턴스 선언 시 자동으로 default initialize 함수가 불러지며,
//custom할 경우 custom initialize 함수가 불러진다.
//FIX: 하고 싶었는데 String으로 전달되었을 때 바로 struct에 넣는 것에 대해서 공부가 필요하다. - OK

struct Address {
    let address: String
    init(address: String) throws {
        if address == "" {
            print("Error! Address is empty")
            throw NSError() as Error
        }
        self.address = address
    }
}

struct Name {
    let name: String
    init(name: String) throws {
        if name == "" {
            print("Error! Name is empty")
            throw NSError() as Error
        }
        self.name = name
    }
}

struct Mobile {
    let mobile: String
    init(mobile: String) throws {
        if mobile == "" { //TODO: 람다식으로 바꾸면 좋을 것같다. - 인식되게..
            print("Error! Mobile is empty")
            throw NSError() as Error
        }
        self.mobile = mobile
    }
}

struct ReceiverInfo {
    let address: Address
    let receiverName: Name
    let receiverMobile: Mobile
    
    init(address: String, receiverName: String, receiverMobile: String) {
        self.address = try! Address(address: address)
        self.receiverName = try! Name(name: receiverName)
        self.receiverMobile = try! Mobile(mobile: receiverMobile)
    }
}

class ParcelInformation {
    
    //S: address, receiverName, receiverMobile은 ReceiverInfo로 묶는다.
    let receiver: ReceiverInfo
    
    //TODO: Discount Enum에 새로운 값이 추가될 경우 코드가 추가되어야 한다.
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

    init(receiver: ReceiverInfo, deliveryCost: Int, discount: Discount) {
        self.receiver = receiver
        self.deliveryCost = deliveryCost
        self.discount = discount
    }
}

enum Discount: Int {
    case none = 0, vip, coupon
}

//???: protocol의 위치는 어디가 적당한 것인가?
protocol ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation)
}

fileprivate final class DatabaseParcelInformationPersistence : ParcelInformationPersistence{
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.")
    }
}

protocol ParcelOrderProcessorProtocol {
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void)
    //init() //???: Protocol에서도 init 함수는 호출되어야 하는지 모르겠다.
}

class ParcelOrderProcessor : ParcelOrderProcessorProtocol {
    
    private let databaseParcelInformationPersistence: ParcelInformationPersistence
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: (ParcelInformation) -> Void) {
        
        // 데이터베이스에 주문 저장
        databaseParcelInformationPersistence.save(parcelInformation: parcelInformation)
        
        onComplete(parcelInformation)
    }
    
    //???: required를 붙이는게 맞는지 아닌지 모르겠다.
    init() {
        self.databaseParcelInformationPersistence = DatabaseParcelInformationPersistence()
    }
    
    
}
