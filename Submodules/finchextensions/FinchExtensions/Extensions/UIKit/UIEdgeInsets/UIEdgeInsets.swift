//
//  UIEdgeInsets.swift
//  FinchExtensions
//
//  Created by VadimQw  on 16.09.2021.
//  Copyright © 2021 Finch Mobile. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    // MARK: - Public methods
    
    func inverted() -> UIEdgeInsets {
        UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
    
}
