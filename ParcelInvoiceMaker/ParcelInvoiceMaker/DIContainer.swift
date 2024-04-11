//
//  DIContainer.swift
//  ParcelInvoiceMaker
//
//  Created by Hong yujin on 4/11/24.
//

import UIKit

final class DIContainer {
    
    static let shared = DIContainer()
    private var services: [String: Any] = [:]
    
    func register<T>(type: T.Type, component: Any) {
        let key = "\(type)"
        services[key] = component
    }
    
    func resolve<T>(type: T.Type) -> T {
        let key = "\(type)"
        return services[key] as! T
    }
    
}
