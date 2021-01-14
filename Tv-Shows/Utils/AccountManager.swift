//
//  AccountManager.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import Foundation

struct AccountManager: UserAccountProtocol {
    
    static let shared = AccountManager()
    
    func setToken(with model: DataModel) {
        let token = model.data.token
        UserDefaults.standard.set(token, forKey: "TOKEN")
        UserDefaults.standard.set(true, forKey: "IS_LOGGED_IN")
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "TOKEN")
        UserDefaults.standard.set(false, forKey: "IS_LOGGED_IN")
    }
}

protocol UserAccountProtocol {
    func setToken(with model: DataModel)
    func logOut()
}
