//
//  AppDelegate.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 07/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let cryptoTableVC = HCTableViewController()
        let navController = UINavigationController(rootViewController: cryptoTableVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }


}

