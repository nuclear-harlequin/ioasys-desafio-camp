//
//  ThreadModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct ThreadResponse: Codable {
    let data: [Thread]
    let meta: Meta
}

// MARK: - Datum
struct Thread: Codable {
    let id: String
    let title: String
    let content: String
    let subject: String
    let user: UserThreads
    let createdAt: String
    let commentCount: Int
}

// MARK: - Meta
struct Meta: Codable {
    let page: Int
    let take: Int
    let itemCount: Int
    let pageCount: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}

struct PostThread: Codable {
    let title: String
    let content: String
    let subjectId: String
}

// MARK: - CreatedThread
struct CreatedThread: Codable {
    let title, content: String
    let user: UserPosted
    let id, createdAt, updatedAt: String
}
