//
//  GraphQLError.swift
//
//  Created by Азиз on 29.08.2021.
//  Copyright © 2021 Finch. All rights reserved.
//

import Apollo

enum GraphQLError: LocalizedError {
    
    case couldNotParse(Error)
    case graphQLError(Error)
    case backendError([Apollo.GraphQLError])
    case apiClientNotInitialized
    case unknownError
    
    // MARK: - Properties
    
    var errorDescription: String? {
        switch self {
        
        case let .couldNotParse(error):
            return error.localizedDescription
            
        case let .graphQLError(error):
            return error.localizedDescription
            
        case let .backendError(errors):
            return errors.compactMap({ $0.description }).joined(separator: "\n")
            
        case .apiClientNotInitialized:
            return "API client not initialized"
            
        case .unknownError:
            return "Unknown error"
        }
    }
}
