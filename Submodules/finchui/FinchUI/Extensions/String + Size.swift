//
//  String + Size.swift
//  TestErrrorView
//
//  Created by Anton on 14.08.2020.
//  Copyright © 2020 Potapov Anton. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - Public methods
    
    func size(withConstraintedHeight height: CGFloat, andWidth width: CGFloat, font: UIFont) -> CGSize {
        
        let constraintRect = CGSize(width: width, height: height)
        let boundingBox = (self as NSString).boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        let newWidth = boundingBox.size.width.rounded(.up)
        let newHeight = boundingBox.size.height.rounded(.up)
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(boundingBox.width)
    }
    
}
