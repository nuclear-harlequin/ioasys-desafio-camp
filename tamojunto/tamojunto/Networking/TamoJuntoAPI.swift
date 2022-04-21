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
    case writeComment
    case makeSearch
    case fetchSubjectsID(subjectID: String)
    case fetchThreadID(threadID: String)
    case deleteComment(commentId: String)
    case deleteThread(threadId: String)
    
    var endpoint: String {
        switch self {
        case .userLogin:
            return "/auth/login"
            
        case .fetchSubjects:
            return "/subjects"
            
        case .fetchThreads:
            return "/threads"
            
        case .writeComment:
            return "/comments"
            
        case .makeSearch:
            return "/search"
            
        case let .fetchSubjectsID(subjectID: subjectID):
            return "/subjects/\(subjectID)"
            
        case let .fetchThreadID(threadID: threadID):
            return "/threads/\(threadID)"
            
        case let .deleteComment(commentId: commentId):
            return "/comments/\(commentId)"
            
        case let .deleteThread(threadId: threadId):
            return "/threads/\(threadId)"
        }
    }
}

