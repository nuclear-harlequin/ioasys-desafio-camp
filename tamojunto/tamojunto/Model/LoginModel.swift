//
//  LoginDTOModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct Login: Codable {
    var email : String
    var password : String
}

struct LoginResponse: Codable {
    let user: UserLogin
    let expiresIn: String
    let accessToken: String
}
