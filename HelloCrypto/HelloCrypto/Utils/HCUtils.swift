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
    
    static func setValue(value: Any, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
        print("Saving: \(value) for: \(key)")
    }
    
    static func getDouble(key: String) -> Double {
        print("Fetching Double for: \(key)")
        return UserDefaults.standard.double(forKey: key)
    }
    
    static func getArray(key: String) -> Array<Any> {
        print("Fetching Array for: \(key)")
        return UserDefaults.standard.array(forKey: key) ?? []
    }
}
