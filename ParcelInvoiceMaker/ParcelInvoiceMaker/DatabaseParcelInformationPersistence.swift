//
//  DatabaseParcelInformationPersistence.swift
//  ParcelInvoiceMaker
//
//  Created by Eunsung on 4/16/24.
//

import Foundation

class DatabaseParcelInformationPersistence: ParcelInformationPersistence {
    func save(parcelInformation: ParcelInformation) {
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.\n\(parcelInformation)")
    }
}
