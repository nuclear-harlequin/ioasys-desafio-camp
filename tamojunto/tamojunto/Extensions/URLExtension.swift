//
//  URLExtension.swift
//  tamojunto
//
//  Created by Giovanna Toni on 15/04/22.
//

import Foundation

extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems

        self = urlComponents.url!
    }
}

// How to use
//var url = URL(string: "https://www.example.com")!
//url.appendQueryItem(name: "name", value: "bhuvan")
