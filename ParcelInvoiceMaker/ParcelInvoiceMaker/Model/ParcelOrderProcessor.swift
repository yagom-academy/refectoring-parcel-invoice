//
//  ParcelInvoiceMaker - ParcelOrderProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

protocol OrderProcessor {
    func process(parcelInformation: ParcelInformation) async -> Void
}

final class ParcelOrderProcessor: OrderProcessor {
    
    private let parcelInformationPersistence: ParcelInformationPersistable
    
    init(parcelInformationPersistence: ParcelInformationPersistable) {
        self.parcelInformationPersistence = parcelInformationPersistence
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation) async {
        await parcelInformationPersistence.save(parcelInformation: parcelInformation)
    }

}
