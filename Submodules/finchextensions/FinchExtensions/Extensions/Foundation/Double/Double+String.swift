//
//  Double+String.swift
//  SberSound
//
//  Created by Николя on 02.06.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

extension Double {
    
    // MARK: - Properties
    
    /// Убирает ноль после запятой
    var cleanValue: String {
        let result = truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
        return result.replacingOccurrences(of: ".", with: ",")
    }
    
}
