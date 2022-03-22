//
//  UIView + gradient.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 17.03.2022.
//

import UIKit

extension UIView {
    
    func setGradientBackground(with colors: [UIColor?], startPoint: CGPoint = .zero, endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0?.cgColor ?? UIColor.clear.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = frame
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
