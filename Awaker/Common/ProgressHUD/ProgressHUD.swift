//
//  ProgressHUD.swift
//  Awaker
//
//  Created by Ilya Turin on 10.12.2021.
//

import UIKit
import SVProgressHUD

final class ProgressHUD: SVIndefiniteAnimatedView {
    
    // MARK: - Private Properties
    
    var color: UIColor? = .blue {
        didSet {
            strokeColor = color
        }
    }
    
    private let size: ProgressHUDSize
    
    
    // MARK: - Init
    
    init(size: ProgressHUDSize = .big) {
        self.size = size
        super.init(frame: CGRect.zero)
        drawSelf()
    }

    required init?(coder aDecoder: NSCoder) {
        size = .big
        color = .white
        super.init(coder: aDecoder)
        drawSelf()
    }
    
    
    // MARK: - Private Methods

    private func drawSelf() {
        radius = size.radius
        strokeThickness = size.stroke
    }
    
}
