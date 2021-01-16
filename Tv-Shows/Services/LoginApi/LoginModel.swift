//
//  LoginModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import Foundation

class LoginModel: BaseModel {
    var email: String = String.empty
    var password: String = String.empty
}

class LoginDataModel: BaseModel {
    var data: Token = Token()
}

class Token: BaseModel {
    var token: String = String.empty
}
