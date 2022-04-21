//
//  UserDefaultsModels.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 20/04/22.
//

import Foundation
class UserID {
    var userID = String() {
        didSet {
            let encoder = JSONEncoder()
            if let userIDEncoded = try? encoder.encode(userID) {
                UserDefaults.standard.set(userIDEncoded, forKey: "userID")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "userID") {
            if let decodedItems = try? JSONDecoder().decode(String.self, from: savedItems) {
                userID = decodedItems
                return
            }
        }

        userID = ""
    }
}

class UserToken {
    var userToken = String() {
        didSet {
            let encoder = JSONEncoder()
            if let userTokenEncoded = try? encoder.encode(userToken) {
                UserDefaults.standard.set(userTokenEncoded, forKey: "userToken")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "userToken") {
            if let decodedItems = try? JSONDecoder().decode(String.self, from: savedItems) {
                userToken = decodedItems
                return
            }
        }

        userToken = ""
    }
}

