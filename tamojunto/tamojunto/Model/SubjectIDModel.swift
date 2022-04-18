//
//  SubjectIDModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 18/04/22.
//

import Foundation

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

