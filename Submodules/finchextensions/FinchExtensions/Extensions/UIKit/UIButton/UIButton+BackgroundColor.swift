//
//  UIButton+BackgroundColor.swift
//  SberSound
//
//  Created by Даниял Деветов on 07.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

extension UIButton {
    
    // MARK: - Public methods
    
    func setBackgroundColor(_ color: UIColor, forState state: UIControl.State) {
        setBackgroundImage(UIImage.imageWithColor(color), for: state)
    }
    
}
