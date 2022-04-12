//
//  UserModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct User: Codable {
    var id, email, password, firstName, lastName, businessName, cnpj, phone: String
    var city: City
    var state: State
    var role : String
    var isActive : Bool
    var avatar : File
    var createdAt, updatedAt, deletedAt : String
}
