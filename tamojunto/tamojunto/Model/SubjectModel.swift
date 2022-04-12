//
//  SubjectModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct Subject: Codable {
    var id, name: String
    var picture: File
    var thread: [String]
    var createdAt, updatedAt, deletedAt : String
}
