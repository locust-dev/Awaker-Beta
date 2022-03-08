//
//  Dictionary+ToString.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 30.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import Foundation

extension Dictionary {
    
    // MARK: - Public methods
    
    /// Конвертирует Dictionary в json подобную строку
    func toString() -> String? {
        
        guard let jsonObject = try? JSONSerialization.data(withJSONObject: self, options: .init(rawValue: 0)) else {
            return nil
        }
        return String(data: jsonObject, encoding: .utf8)
    }
    
}
