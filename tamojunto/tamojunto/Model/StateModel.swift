//
//  StateModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 12/04/22.
//

import Foundation

struct State: Codable {
    var id, name, createdAt, updatedAt, deletedAt : String
    var cities : [String]
}
