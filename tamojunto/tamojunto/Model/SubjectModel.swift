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
