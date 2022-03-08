//
//  ButtonWithTouchArea.swift
//  SberSound
//
//  Created by Finch on 22.10.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

final class ButtonWithTouchArea: NLButton {
    
    // MARK: - Properties
    
    private let touchAreaInsets: UIEdgeInsets?
    
    
    // MARK: - Init
    
    init(touchAreaPadding: UIEdgeInsets? = nil) {
        self.touchAreaInsets = touchAreaPadding
        super.init(frame: .zero)
    }
    
    
    // MARK: - Life cycle
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        guard let insets = touchAreaInsets else {
            return super.point(inside: point, with: event)
        }
        
        let invertedInsets = insets.inverted()
        let rect = bounds.inset(by: invertedInsets)
        return rect.contains(point)
    }
    
}
