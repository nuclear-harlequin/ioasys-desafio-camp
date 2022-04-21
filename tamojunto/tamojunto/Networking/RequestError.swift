//
//  RequestError.swift
//  tamojunto
//
//  Created by Giovanna Toni on 13/04/22.
//

import Foundation


enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
