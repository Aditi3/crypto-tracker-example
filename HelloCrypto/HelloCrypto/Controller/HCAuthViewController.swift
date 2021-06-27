//
//  HCAuthViewController.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 17/12/20.
//  Copyright © 2020 Aditi Agrawal. All rights reserved.
//

import UIKit
import LocalAuthentication

class HCAuthViewController: UIViewController {
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presentAuth()
    }
    
    // MARK: - Setup
    
    func setup() {
        self.view.backgroundColor = .systemBackground
    }
    
    func presentAuth() {
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Hello Crypto is protected by biometrics") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    let cryptoTableVC = HCCryptoTableViewController()
                    let navController = UINavigationController(rootViewController: cryptoTableVC)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                }
            } else {
                self.presentAuth()
            }
        }
    }
}
