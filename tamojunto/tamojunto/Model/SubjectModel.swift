//
//  SubjectModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct Subject: Codable {
    var id: String
    var name: String
    var picture: File?
    var threadCount: Int
}

struct SubjectIDResponse: Codable {
    let data: [SubjectIDThread]
    let meta: MetaSubjectIDThread
}

// MARK: - Datum
struct SubjectIDThread: Codable {
    let id, title, content: String
    let user: UserSubjectIDThread
    let createdAt: String
    let commentCount: Int
}

// MARK: - User
struct UserSubjectIDThread: Codable {
    let id, email, firstName, lastName: String
    let businessName, cnpj, phone: String
}

// MARK: - Meta
struct MetaSubjectIDThread: Codable {
    let page, itemCount: Int
    let pageCount: Int?
    let hasPreviousPage, hasNextPage: Bool
}
