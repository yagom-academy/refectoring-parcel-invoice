//
//  DatabaseParcelInformationPersistence.swift
//  ParcelInvoiceMaker
//
//  Created by Eunsung on 4/16/24.
//

import Foundation

class DatabaseParcelInformationPersistence: parcelInformationPersistence {
    private let nameCountLimit = 10
    
    func save(parcelInformation: ParcelInformation) throws {
        try validateParceInformation(parceInformation: parcelInformation)
        // 데이터베이스에 주문 정보 저장
        print("발송 정보를 데이터베이스에 저장했습니다.\n\(parcelInformation)")
    }
    // 모델 검증 // 임시로 name만 진행
    func validateParceInformation(parceInformation: ParcelInformation) throws {
        guard parceInformation.receiver.name.count < nameCountLimit else {
            throw personValidationError.nameCountLimitError
        }
    }
}

enum personValidationError: Error {
    case nameCountLimitError
}
