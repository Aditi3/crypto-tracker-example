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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        presentAuth()
    }
    
    // MARK: - Setup
    
    func setup() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGray5
        } else {
            // Fallback on earlier versions
            self.view.backgroundColor = .lightText
        }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
