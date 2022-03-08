//
//  String+Sizes.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 31.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - Public methods
    
    /// Возвращает ширину строки основываясь на переданной высоте и шрифте
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font], context: nil
        )
        
        return boundingBox.width
    }
    
    /// Возвращает высоту строки основываясь на переданной ширине и шрифте
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font], context: nil
        )
        
        return CGFloat(ceilf(Float(boundingBox.height)))
    }
    
    /// Возвращает высоту строки основываясь на переданной ширине и арибутам
    func heightWithConstrainedWidth(width: CGFloat,
                                    attributes: [NSAttributedString.Key: NSObject]) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: attributes, context: nil
        )
        
        return boundingBox.height
    }
    
}
