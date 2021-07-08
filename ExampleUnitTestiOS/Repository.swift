//
//  Repository.swift
//  ExampleUnitTestiOS
//
//  Created by Hildequias Junior on 06/07/21.
//

import Foundation

class Repository: NSObject {

    let keyConstaint = "keyEncrypt"
    
    func getKey() -> String {
        return UserDefaults.standard.string(forKey: keyConstaint) ?? ""
    }
    
    func saveKey(key: String) {
        UserDefaults.standard.setValue(key, forKey: keyConstaint)
        UserDefaults.standard.synchronize()
    }
}
