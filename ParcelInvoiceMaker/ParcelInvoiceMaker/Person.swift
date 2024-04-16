//
//  Person.swift
//  ParcelInvoiceMaker
//
//  Created by Eunsung on 4/16/24.
//

import Foundation

struct Person {
    private let address: String
    private var name: String
    private var mobile: String
    
    init(address: String, name: String, mobile: String) {
        self.address = address
        self.name = name
        self.mobile = mobile
    }
    
    func getAddress() -> String {
        return self.address
    }
    func getName() -> String {
        return self.name
    }
    func getMobile() -> String {
        return self.mobile
    }
}
