//
//  Collection+SafeSubscript.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 30.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

extension Collection {
    
    /// Возвращает элемент по указанному индексу, если он находится в пределах границ, иначе вернер nil
    subscript (safe index: Index) -> Iterator.Element? {
        indices.contains(index) ? self[index] : nil
    }
    
}
