//
//  ThreadIDModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 18/04/22.
//

import Foundation

struct ThreadIDResponse: Codable {
    let id, title, content: String
    let user: UserThreadID
    let comments: [Comment]?
    let createdAt: String
    let commentCount: Int
}

struct Comment: Codable {
    let id, content, createdAt, updatedAt: String
    let user: UserThreadID
}

struct UserThreadID: Codable {
    let id, email, firstName, lastName: String
    let businessName, cnpj, phone: String
    let avatar: File?
}
