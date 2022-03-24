//
//  UIView+Glowing.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 23.03.2022.
//

import UIKit

extension UIView {
    
    func turnOnBacklight(_ color: UIColor?) {
        
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 17
        
        let layer1 = CALayer()
        layer1.shadowColor = color?.cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 15
        
        layer.addSublayer(layer1)
        
        let layer2 = CALayer()
        layer2.shadowColor = color?.cgColor
        layer2.shadowOpacity = 1
        layer2.shadowRadius = 12
        
        layer1.addSublayer(layer2)
        
        let layer3 = CALayer()
        layer3.shadowColor = color?.cgColor
        layer3.shadowOpacity = 1
        layer3.shadowRadius = 9
        
        layer2.addSublayer(layer3)
        
        let layer4 = CALayer()
        layer4.shadowColor = color?.cgColor
        layer4.shadowOpacity = 1
        layer4.shadowRadius = 6
        
        layer3.addSublayer(layer4)
        
        let layer5 = CALayer()
        layer5.shadowColor = color?.cgColor
        layer5.shadowOpacity = 1
        layer5.shadowRadius = 4
        
        layer4.addSublayer(layer5)
    }
    
    func turnOffBacklight() {
        
        layer.shadowColor = nil
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        
        layer.sublayers?.removeLast()
    }
}
