//
//  UserModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct LoginResponse: Codable {
    let user: UserLogin
    let expiresIn: String
    let accessToken: String
}

struct UserLogin: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let cnpj: String
    let phone: String
    let avatar: File?
}

struct User: Codable {
    var id, email, password, firstName, lastName, businessName, cnpj, phone: String
    var city: City
    var state: State
    var role : String
    var isActive : Bool
    var avatar : File
    var createdAt, updatedAt, deletedAt : String
}

struct UserThreads: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let businessName: String
    let cnpj: String
    let phone: String
}

// MARK: - UserCreatedThread
struct UserCreatedThread: Codable {
    let id, email, firstName, lastName: String
    let businessName, cnpj, phone: String
    let avatar: File?
}
