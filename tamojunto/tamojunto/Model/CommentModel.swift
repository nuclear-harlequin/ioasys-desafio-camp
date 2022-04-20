//
//  CommentModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct Comment: Codable {
    let id, content, createdAt, updatedAt: String
    let user: UserThreadID
}

// MARK: - CreatedComment
struct CreatedComment: Codable {
    let content: String
    let user: UserPosted
    let id: String
    let createdAt: String
    let updatedAt: String
}

