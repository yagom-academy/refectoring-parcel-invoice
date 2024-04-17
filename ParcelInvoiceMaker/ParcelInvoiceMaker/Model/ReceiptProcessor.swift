//
//  ReceiptProcessor.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/16/24.
//


import Foundation

protocol ReceiptProcessorable {
    func send(parcelInformation: ParcelInformation) async -> Void
}

final class ReceiptProcessor: ReceiptProcessorable {
    func send(parcelInformation: ParcelInformation) async {
        print("영수증이 \(parcelInformation.getReceiptTitle())로 전달되었습니다.")
    }
}
