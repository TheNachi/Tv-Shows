//
//  AccountManager.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import Foundation

struct AccountManager: UserAccountProtocol {
    
    static let shared = AccountManager()
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "IS_LOGGED_IN")
    }
    
    func setToken(with model: LoginDataModel) {
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
    func setToken(with model: LoginDataModel)
    func isLoggedIn() -> Bool
    func logOut()
}
