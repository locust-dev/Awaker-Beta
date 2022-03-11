//
//  ProgressHUDSize.swift
//  Awaker
//
//  Created by Ilya Turin on 10.12.2021.
//

import UIKit

enum ProgressHUDSize {
    
    case big
    case medium
    
    
    // MARK: - Properties
    
    var side: CGFloat {
        
        switch self {
            
        case .big:
            return 44
            
        case .medium:
            return 22
        }
    }
    
    var cgSize: CGSize {
        return CGSize(width: side, height: side)
    }
    
    var radius: CGFloat {
        
        switch self {
            
        case .big:
            return 18
            
        case .medium:
            return 9
        }
    }
    
    var stroke: CGFloat {
        
        switch self {
            
        case .big:
            return 6
            
        case .medium:
            return 3
        }
    }
    
}
