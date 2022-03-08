//
//  UIImage + Additionals.swift
//  FinchExtensions
//
//  Created by VadimQw  on 10.02.2022.
//  Copyright © 2022 Finch Mobile. All rights reserved.
//

import UIKit

extension UIImage {
    
    // MARK: - Public methods
    
    static func imageWithColor(_ color: UIColor,
                               rect: CGRect = .init(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? .init()
    }
    
}
