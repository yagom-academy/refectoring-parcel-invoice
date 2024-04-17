//
//  ParcelInvoiceMaker - ParcelOrderViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol ParcelOrderProtocol {
    func process(parcelInformation: ParcelInformation) async throws
}

class ParcelOrderViewController: UIViewController, ParcelOrderViewDelegate {
    private let parcelOrderProcessor: ParcelOrderProtocol
    private let alertManager: alertManager
    
    init(parcelOrderProcessor: ParcelOrderProtocol, alertManager: alertManager = AlertManager()){
        self.parcelOrderProcessor = parcelOrderProcessor
        self.alertManager = alertManager
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "택배보내기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func parcelOrderMade(_ parcelInformation: ParcelInformation) {
        Task {
            do {
                try await parcelOrderProcessor.process(parcelInformation: parcelInformation)
                DispatchQueue.main.async {
                    let invoiceViewController: InvoiceViewController = .init(parcelInformation: parcelInformation)
                    self.navigationController?.pushViewController(invoiceViewController, animated: true)
                }
            } catch personValidationError.nameCountLimitError {
                alertManager.showOneButtonAlert(viewController: self, title: "error", message: "name error")
            } catch personValidationError.mobileCountLimitError {
                alertManager.showOneButtonAlert(viewController: self, title: "error", message: "mobile error")
            } catch personValidationError.addressCountLimitError {
                alertManager.showOneButtonAlert(viewController: self, title: "error", message: "address error")
            } catch {
                print(error)
            }
        }
    }
    
    override func loadView() {
        view = ParcelOrderView(delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

