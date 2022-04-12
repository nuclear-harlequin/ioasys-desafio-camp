//
//  CreateUserDTOModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct CreateUserDTO: Codable {
    var email : String
    var password : String
    var firstName : String
    var lastName : String
    var businessName : String
    var cnpj : String
    var phone : String
    var cityId : String
    var stateId : String
}
