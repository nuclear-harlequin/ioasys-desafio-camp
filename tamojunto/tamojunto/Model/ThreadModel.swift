//
//  ThreadModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct Thread: Codable {
    var id, title, content: String
    var subject: Subject
    var user: User
    var comments : [String]
    var createdAt, updatedAt, deletedAt : String
}
