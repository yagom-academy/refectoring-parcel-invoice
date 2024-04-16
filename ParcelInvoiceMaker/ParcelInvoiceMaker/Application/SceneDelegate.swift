//
//  ParcelInvoiceMaker - SceneDelegate.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene: UIWindowScene = (scene as? UIWindowScene) else { return }
        
        let container = DIContainer.shared
        
        container.register(
            type: ParcelInformationPersistable.self,
            component: DatabaseParcelInformationPersistence()
        )
        
        let database = container.resolve(type: ParcelInformationPersistable.self)
        
        container.register(
            type: ParcelOrderProcessor.self,
            component: ParcelOrderProcessor(parcelInformationPersistence: database))
        
        let processor = container.resolve(type: ParcelOrderProcessor.self)
        
        container.register(
            type: ParcelOrderViewController.self,
            component: ParcelOrderViewController(orderProcessor: processor))
        
        let viewController = container.resolve(type: ParcelOrderViewController.self)

        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
        
        let window: UIWindow = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

