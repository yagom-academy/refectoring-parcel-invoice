//
//  ParcelInvoiceMaker - ParcelOrderProcessor.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

protocol OrderProcessor {
    func process(parcelInformation: ParcelInformation, onComplete: @escaping (ParcelInformation) -> Void)
}

final class ParcelOrderProcessor: OrderProcessor {
    
    private let parcelInformationPersistence: ParcelInformationPersistable
    
    init(parcelInformationPersistence: ParcelInformationPersistable) {
        self.parcelInformationPersistence = parcelInformationPersistence
    }
    
    // 택배 주문 처리 로직
    func process(parcelInformation: ParcelInformation, onComplete: @escaping (ParcelInformation) -> Void) {

        parcelInformationPersistence.save(parcelInformation: parcelInformation) {
            onComplete(parcelInformation)
        }
    }

}
