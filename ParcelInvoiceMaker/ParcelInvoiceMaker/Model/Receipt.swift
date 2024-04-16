//
//  Receipt.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/16/24.
//

import Foundation

enum ReceiptType: Int, CaseIterable {
    case email, sms
    
    var title: String {
        switch self {
        case .email:
            return "이메일"
        case .sms:
            return "문자"
        }
    }
}


