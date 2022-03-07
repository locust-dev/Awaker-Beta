//
//  DispatchQueue.swift
//  Questionnaire
//
//  Created by Ilya Turin on 10.12.2021.
//

import Foundation

// MARK: - Main Queue

public func mainQueue(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

public func mainQueue(delay: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: block)
}

public func tryMainQueue(_ block: @escaping () -> Void) {
    
    if Thread.current.isMainThread {
        block()
    } else {
        mainQueue(block)
    }
}


// MARK: - Global Queue

public func globalQueue(_ block: @escaping () -> Void) {
    DispatchQueue.global().async(execute: block)
}

public func globalQueue(delay: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + delay, execute: block)
}
