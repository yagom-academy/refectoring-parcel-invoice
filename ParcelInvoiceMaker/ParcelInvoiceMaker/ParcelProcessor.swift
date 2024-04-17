//
//  ParcelInvoiceMaker - ParcelProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

protocol parcelInformationPersistence {
    func save(parcelInformation: ParcelInformation) throws
}

class ParcelOrderProcessor: ParcelOrderProtocol {
    private var parceInfoPersistence: parcelInformationPersistence
    
    init(parceInfoPersistence: parcelInformationPersistence = DatabaseParcelInformationPersistence()) {
        self.parceInfoPersistence = parceInfoPersistence
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation) async throws {
        
        // 데이터베이스에 주문 저장
        try parceInfoPersistence.save(parcelInformation: parcelInformation)
    }
}
