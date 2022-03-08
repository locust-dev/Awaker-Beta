//
//  UIColor+Hex.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 31.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Properties
    
    var hexString: NSString {
        
        let colorRef = cgColor.components
        let red: CGFloat = colorRef![0] // swiftlint:disable:this force_unwrapping
        let green: CGFloat = colorRef![1] // swiftlint:disable:this force_unwrapping
        let blue: CGFloat = colorRef![2] // swiftlint:disable:this force_unwrapping
        
        return NSString(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
    }
    
    
    // MARK: - Init
    
    /// Инициализирует UIColor из hex строки
    convenience init?(hex: String, alpha: Float = 1) {
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha = CGFloat(alpha)
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        if length == 6 {
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255
            blue = CGFloat(rgb & 0x0000FF) / 255
            
        } else if length == 8 {
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255
            alpha = CGFloat(rgb & 0x000000FF) / 255
            
        } else {
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1) {
        
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: alpha
        )
    }
    
    
    // MARK: - Public methods
    
    func hexString(includeAlpha: Bool) -> String {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        if includeAlpha {
            return String(
                format: "#%02X%02X%02X%02X",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255)),
                Int(round(alpha * 255))
            )
        } else {
            return String(
                format: "#%02X%02X%02X",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255))
            )
        }
    }
    
}
