//
//  String+HTMLAttributed.swift
//  SberSound
//
//  Created by Илья Тюрин on 20.08.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Public methods
    
    /// Преобразовывает HTML text в AttributedString
    func descriptionAttributedString(fontName: String,
                                     size: Int = 15,
                                     hex color: String) -> NSAttributedString? {
        
        var hex = color
        
        if hex.first != "#" {
            hex.insert("#", at: startIndex)
        }
        
        let htmlCSSString = "<style>html *{" +
                            "font-size: \(size);" +
                            "color: \(hex) !important;" +
                            "font-family: \(fontName)}</style> \(self)"
        
        guard let data = htmlCSSString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
    
    func htmlAttributedString(fontName: String, size: Int, colorHex: NSString) -> NSAttributedString? {
        let htmlCSSString = "<style>" +
            "html *" +
            "{" +
            "font-size: \(size);" +
            "color: \(colorHex) !important;" +
            "font-family: \(fontName)" +
            "}</style> \(self)"
        
        guard let data = htmlCSSString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
  
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
    
}
