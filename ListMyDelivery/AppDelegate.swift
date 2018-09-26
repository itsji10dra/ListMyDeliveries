//
//  AppDelegate.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Configuration.checkConfiguration()
        _ = ReachabilityManager.shared
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = ListDeliveryVC()
        let navigationController = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

