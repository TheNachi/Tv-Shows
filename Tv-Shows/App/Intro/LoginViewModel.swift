//
//  LoginViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    init(with apiService: LoginService?) {
        super.init(with: apiService)
    }
    
    public func validateEmailAndPassword(email: String, password: String) -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    public func loginUser(with loginModel: LoginModel, delegate: LoginDelegate) {
        guard let apiService = self.apiService as? LoginService else { return }
        apiService.loginUser(with: loginModel, loginDelegate: delegate)
    }
    
    public func emailIsValid(email: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return predicate.evaluate(with: email)
    }
    
    public func rememberMe(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "EMAIL")
        UserDefaults.standard.set(password, forKey: "PASSWORD")
    }
    
    public func getSavedEmail() -> String {
        guard let email = UserDefaults.standard.string(forKey: "EMAIL") else {
            return String.empty
        }
        return email
    }
    
    public func getSavedPassword() -> String {
        guard let password = UserDefaults.standard.string(forKey: "PASSWORD") else { return String.empty}
        return password
    }
}
