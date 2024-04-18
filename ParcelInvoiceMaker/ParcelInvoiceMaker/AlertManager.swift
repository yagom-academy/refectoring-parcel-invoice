//
//  AlertManager.swift
//  ParcelInvoiceMaker
//
//  Created by EUNSUNG on 4/17/24.
//

import Foundation
import UIKit

protocol AlertProcessor {
    func showOneButtonAlert(on viewController: UIViewController,title:String, message: String)
}

class AlertManager: AlertProcessor {
    func showOneButtonAlert(on viewController: UIViewController,title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "confirm", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
