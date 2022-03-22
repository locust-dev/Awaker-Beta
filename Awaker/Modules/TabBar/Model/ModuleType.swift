//
//  ModuleType.swift
//  Awaker
//
//  Created by Ilya Turin on 10.03.2022.
//

enum ModuleType {
    
    case alarms
    case profile
    
    var title: String {
        
        switch self {
            
        case .alarms:
            return "Alarms"
            
        case .profile:
            return "Profile"
        }
    }
}
