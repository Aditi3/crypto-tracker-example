//
//  HCUtils.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 17/12/20.
//  Copyright © 2020 Aditi Agrawal. All rights reserved.
//

import Foundation

internal struct HCUtils {
        
    // Access Shared Defaults Object
    static let userDefaults = UserDefaults.standard
    
    static func isAppSecure() -> Bool {
       return userDefaults.object(forKey: "secure") as? Bool ?? false
    }
    
    static func updateAppSecureKey(secure: Bool) {
        UserDefaults.standard.setValue(secure, forKey: "secure")
    }

}
