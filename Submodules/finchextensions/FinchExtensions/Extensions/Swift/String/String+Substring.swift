//
//  String+Substring.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 31.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

extension String {
    
    // MARK: - Public methods
    
    /// Возвращает строку начиная с переданного индекса
    func substring(from index: Int) -> String {
        String(self[self.index(startIndex, offsetBy: index)...])
    }
    
    /// Вырезает переданный диапазон и возвращает строку
    func substring(with range: Range<Int>) -> String {
        
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
}
