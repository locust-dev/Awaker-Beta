//
//  ErrorModel.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import Foundation

enum ErrorModel: Error {
    
    // Entire
    case somethingWentWrong
    
    var description: String {
        
        switch self {
            
        case .somethingWentWrong:
            return ""
            
        }
    }
    
}
