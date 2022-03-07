//
//  ViewOutput.swift
//  Questionnaire
//
//  Created by Ilya Turin on 08.12.2021.
//

import Foundation

protocol ViewOutput: AnyObject {
    
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func back()
}


// MARK: - Default Implementation
extension ViewOutput {
    
    func viewIsReady() {  }
    
    func viewWillAppear() {  }
    
    func viewDidAppear() {  }
    
    func viewWillDisappear() {  }
    
    func viewDidDisappear() {  }
    
    func back() { }
}
