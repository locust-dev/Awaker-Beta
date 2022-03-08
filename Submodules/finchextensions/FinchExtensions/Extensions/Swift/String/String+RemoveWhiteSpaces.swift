//
//  String+RemoveWhiteSpaces.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 31.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

extension String {
    
    // MARK: - Public methods
    
    /// Удаляет пробелы в начале и конце строки
    mutating func removeWhiteSpacesFromBeginnAndEnd() {
        self = trimmingCharacters(in: .whitespaces)
    }
    
}
