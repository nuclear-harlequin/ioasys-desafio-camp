//
//  TamoJuntoAPI.swift
//  tamojunto
//
//  Created by Giovanna Toni on 13/04/22.
//

import Foundation

enum TamoJunto {
    static let baseUrl = "https://camp-tamojunto.herokuapp.com"
    
    case userLogin
    case fetchSubjects
    case fetchThreads
    
    var path: String {
        switch self {
        case .userLogin:
            return "/auth/sign-in"
            
        case .fetchSubjects:
            return "/subjects"
            
        case .fetchThreads:
            return "/threads?order=ASC&page=1&take=10"
            
        }
    }
}
