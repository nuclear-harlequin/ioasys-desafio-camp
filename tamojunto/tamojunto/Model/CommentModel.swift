//
//  CommentModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct Comment: Codable {
    var id, content : String
    var thread: Thread
    var user: User
    var createdAt, updatedAt, deletedAt : String
}
