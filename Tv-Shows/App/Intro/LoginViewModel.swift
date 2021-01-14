//
//  LoginViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    init(with data: BaseModel?, apiService: LoginService?) {
        super.init(with: data, apiService: apiService)
    }
    
    public func validateEmailAndPassword(email: String,
        password: String) -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    public func loginUser(with loginModel: LoginModel, delegate: LoginDelegate) {
        guard let apiService = self.apiService as? LoginService else { return }
        apiService.loginUser(with: loginModel, delegate: delegate)
    }
    
    public func emailIsValid(email: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return predicate.evaluate(with: email)
    }
}
