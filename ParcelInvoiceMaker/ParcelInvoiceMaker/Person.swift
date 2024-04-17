//
//  Person.swift
//  ParcelInvoiceMaker
//
//  Created by Eunsung on 4/16/24.
//

import Foundation

struct Person {
    let address: String
    var name: String
    var mobile: String
    
    init(address: String, name: String, mobile: String) {
        self.address = address
        self.name = name
        self.mobile = mobile
    }
}
