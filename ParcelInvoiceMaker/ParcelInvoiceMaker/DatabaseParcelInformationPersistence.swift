//
//  DatabaseParcelInformationPersistence.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/10/24.
//

import Foundation

protocol ParcelInformationPersistable {
    func save(parcelInformation: ParcelInformation, onSuccess: () -> Void)
}

struct DatabaseParcelInformationPersistence: ParcelInformationPersistable {
 
    func save(parcelInformation: ParcelInformation, onSuccess: () -> Void) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.")
        
        onSuccess()
    }
    
}
