//
//  UIVIew+Animations.swift
//  Questionnaire
//
//  Created by Ilya Turin on 04.03.2022.
//

import UIKit

extension UIView {
    
    func appearWithFade(duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        
        alpha = 0
        
        UIView.animate(withDuration: duration) {
            self.alpha = 1
            
        } completion: { _ in
            
            guard let completion = completion else {
                return
            }

            completion()
        }
    }
    
    func dissapearWithFade(duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        } completion: { _ in
            
            guard let completion = completion else {
                return
            }

            completion()
        }
    }
    
}
