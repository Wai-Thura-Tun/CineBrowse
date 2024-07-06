//
//  UserDefaultsManager.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

extension UserDefaults {
    static let key: String = "OldUser"
    
    static func setUser() {
        standard.set(true, forKey: key)
    }
    
    static func getUser() -> Bool {
        return standard.bool(forKey: key)
    }
}
