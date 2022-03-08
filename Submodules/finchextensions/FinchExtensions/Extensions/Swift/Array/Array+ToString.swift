//
//  Array+ToString.swift
//  SberSound
//
//  Created by Nick barkovski on 26.10.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import Foundation

extension Array {
    
    // MARK: - Public methods
    
    /// Конвертирует Array в json подобную строку
    func toString() -> String? {
        
        guard let jsonObject = try? JSONSerialization.data(withJSONObject: self, options: .init(rawValue: 0)) else {
            return nil
        }
        return String(data: jsonObject, encoding: .utf8)
    }
    
}
