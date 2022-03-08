//
//  String+Mask.swift
//  SberSound
//
//  Created by Даниял Деветов on 28.10.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

extension String {
    
    /// Добавляет маску на строку
    /// Пример маски +X (XXX) XXX-XX-XX
    func setMask(_ mask: String) -> String {
        
        let cleanPhoneNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        var result = ""
        
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
            
        }
        
        return result
    }
}
