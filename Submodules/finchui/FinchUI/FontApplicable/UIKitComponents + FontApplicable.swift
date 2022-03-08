//
//  UIKitComponents + FontApplicable.swift
//  SberSound
//
//  Created by Илья Тюрин on 26.08.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

// MARK: - UILabel + FontApplicable
extension UILabel: FontApplicable {
    
    func apply(textStyle: Fonts) {
        font = textStyle.font
    }

}


// MARK: - UIButton + FontApplicable
extension UIButton: FontApplicable {
    
    func apply(textStyle: Fonts) {
        titleLabel?.apply(textStyle: textStyle)
    }
    
}


// MARK: - UITextView + FontApplicable
extension UITextView: FontApplicable {
    
    func apply(textStyle: Fonts) {
        font = textStyle.font
    }
    
}


// MARK: - UITextField + FontApplicable
extension UITextField: FontApplicable {
    
    func apply(textStyle: Fonts) {
        font = textStyle.font
    }
    
}
