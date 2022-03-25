//
//  MainFont.swift
//  Awaker
//
//  Created by Ilya Turin on 25.03.2022.
//

import UIKit

enum MainFont {
    
    // MARK: - Types
    
    case bold
    case semiBold
    case medium
    case regular
    case light
    
    enum FontName {
        
        static let regular = "Comfortaa-Regular"
        static let medium = "Comfortaa-Medium"
        static let bold = "Comfortaa-Bold"
        static let light = "Comfortaa-Light"
        static let semiBold = "Comfortaa-SemiBold"
    }
    
    
    // MARK: - Public methods
    
    func withSize(_ size: CGFloat) -> UIFont {
        
        var font: UIFont?

        switch self {
            
        case .bold:
            font = UIFont(name: FontName.bold, size: size)
            
        case .light:
            font = UIFont(name: FontName.light, size: size)
            
        case .medium:
            font = UIFont(name: FontName.medium, size: size)
            
        case .regular:
            font = UIFont(name: FontName.regular, size: size)
            
        case .semiBold:
            font = UIFont(name: FontName.semiBold, size: size)
        }
        
        return font ?? UIFont.systemFont(ofSize: 16)
    }
}
