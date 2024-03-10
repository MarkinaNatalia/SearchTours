//
//  CustomUserDefaults.swift
//  SearchTours
//
//  Created by Наталья on 10.03.2024.
//

import Foundation

final class CustomUserDefaults {
    static let shared = CustomUserDefaults()
    
    private static let KEY_API_KEY = "api_key"
    
    func saveApiKey(key: String) {
        let defaults = UserDefaults.standard
        defaults.set(key, forKey: CustomUserDefaults.KEY_API_KEY)
    }
    
    func getApiKey() -> String {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: CustomUserDefaults.KEY_API_KEY) as? String ?? ""
        return token
    }
    
    func haveApiKey() -> Bool {
        return !getApiKey().isEmpty
    }
}
