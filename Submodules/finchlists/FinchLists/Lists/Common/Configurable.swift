//
//  Configurable.swift
//  FinchLists
//
//  Created by Vladimir Pchelyakov on 06.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

protocol Configurable {
    
    associatedtype Model
    
    func configure(with model: Model)
    
}
