//
//  DataConverterInput.swift
//  FinchLists
//
//  Created by Vladimir Pchelyakov on 06.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

protocol DataConverterInput {
    
    associatedtype Model
    associatedtype ViewModel
    
    func createViewModelFrom(_ model: Model) -> ViewModel
    
}
