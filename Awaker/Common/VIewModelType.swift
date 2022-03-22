//
//  VIewModelType.swift
//  Awaker
//
//  Created by Ilya Turin on 17.03.2022.
//

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
