//
//  DatabasePath.swift
//  Awaker
//
//  Created by Ilya Turin on 11.12.2021.
//

enum DatabasePath {
   
    case profile
    
    var stringPath: String {
        
        switch self {
            
        case .profile:
            return "profile"
        }
    }
    
}
