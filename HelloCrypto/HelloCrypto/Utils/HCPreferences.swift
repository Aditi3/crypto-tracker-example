//
//  HCUtils.swift
//  HelloCrypto
//
//  Created by Aditi Agrawal on 17/12/20.
//  Copyright © 2020 Aditi Agrawal. All rights reserved.
//

import Foundation

internal struct HCPreferences {
    
    // Access Shared Defaults Object
    static let userDefaults = UserDefaults.standard
    
    static func isAppSecure() -> Bool {
        return userDefaults.bool(forKey: "secure")
    }
    
    static func updateAppSecureKey(secure: Bool) {
        userDefaults.setValue(secure, forKey: "secure")
    }
    
    static func setValue(value: Any, key: String) {
        userDefaults.setValue(value, forKey: key)
        print("Saving: \(value) for: \(key)")
    }
    
    static func getDouble(key: String) -> Double {
        print("Fetching Double for: \(key)")
        return userDefaults.double(forKey: key)
    }
    
    static func getArray(key: String) -> Array<Any> {
        print("Fetching Array for: \(key)")
        return userDefaults.array(forKey: key) ?? []
    }
}
