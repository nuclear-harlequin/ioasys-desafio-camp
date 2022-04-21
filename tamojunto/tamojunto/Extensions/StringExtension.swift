//
//  StringExtension.swift
//  tamojunto
//
//  Created by Giovanna Toni on 13/04/22.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
