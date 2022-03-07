//
//  AlertAction.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import UIKit

struct AlertAction {
    
    // MARK: - Properties
    
    let title: String
    let style: UIAlertAction.Style
    let action: (() -> Void)?
    
    
    // MARK: - Init
    
    init(title: String, style: UIAlertAction.Style = .default, action: (() -> Void)? = nil) {
        
        self.title = title
        self.style = style
        self.action = action
    }

}
