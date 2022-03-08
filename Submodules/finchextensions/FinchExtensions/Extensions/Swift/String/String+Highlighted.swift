//
//  String+Highlighted.swift
//  SberSound
//
//  Created by Nick barkovski on 02.11.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

extension String {
    
    // Выделяет найденый тест
    func setHighlighted(with search: String,
                        selectedColor: UIColor = .white,
                        mainColor: UIColor = .white) -> NSMutableAttributedString {
        
        let attributedText = NSMutableAttributedString(string: self)
        
        let mainRange = NSString(string: self).range(of: self, options: .caseInsensitive)
        let mainHighlightedAttributes = [NSAttributedString.Key.foregroundColor: mainColor]
        
        attributedText.addAttributes(mainHighlightedAttributes, range: mainRange)
        
        
        let selectedRange = NSString(string: self).range(of: search, options: .caseInsensitive)
        let selectedHighlightedAttributes = [NSAttributedString.Key.foregroundColor: selectedColor]
        
        attributedText.addAttributes(selectedHighlightedAttributes, range: selectedRange)
        
        return attributedText
    }
    
}
