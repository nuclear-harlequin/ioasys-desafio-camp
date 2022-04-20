//
//  SearchResponseModel.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 20/04/22.
//


import Foundation

struct SearchResponse: Codable {
    var data: [SearchResponseThreads]
    var meta: Meta
}

struct SearchResponseThreads: Codable {
    var id: String
    var title: String
    var content: String
    var subject: String
    var createdAt: String
    var commentCount: Int
}
