//
//  UIScreen+Type.swift
//  SberSound
//
//  Created by Николя on 24.06.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

public enum ScreenType: CGFloat {
    
    case inch4 = 568 // iPhone 5, 5c, 5s, iPod 5
    case inch4_7 = 667 // iPhone 6, 6s, 7, 8
    case inch5_5 = 736 // iPhone 6+, 6s+, 7+, 8+
    case inch5_8 = 812 // iPhone X
    case inch9_7 = 1024 // iPad mini & iPad Air & iPad Pro
    case inch10_5 = 1112 // iPad Pro
    case inch12_9 = 1366 // iPad Pro
    case other
    
    
    // MARK: - Public methods
    
    static func item<T>(for deviceSizes: (size: ScreenType, item: T)...) -> T? {
        
        let currentSize = UIScreen.main.screenType.rawValue
        
        if let item = (deviceSizes.sorted { $0.size.rawValue > $1.size.rawValue }
                                  .filter { $0.size.rawValue <= currentSize })
                                  .first?.item {
            
            return item
        }
        
        return deviceSizes.enumerated().min(by: {
            abs($0.1.size.rawValue - currentSize) < abs($1.1.size.rawValue - currentSize)
        })?
        .element.item
    }
    
}


// MARK: - UIScreen + ScreenType
extension UIScreen {
    
    var screenType: ScreenType {
        let maxLength: CGFloat = max(bounds.width, bounds.height)
        return ScreenType(rawValue: maxLength) ?? .other
    }
    
}
