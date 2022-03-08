//
//  String+IsNumeric.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 31.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Public methods
    
    /// Проверяет является ли текущая строка числом. Возвращает true если строка состоит из цифр.
    func isNumeric() -> Bool {
        !components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "").isEmpty
    }
    
}
