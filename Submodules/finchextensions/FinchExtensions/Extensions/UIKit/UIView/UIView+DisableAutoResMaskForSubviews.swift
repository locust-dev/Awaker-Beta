//
//  UIViewController+DisableAutoResMaskForSubviews.swift
//  Stoloto
//
//  Created by Arcani on 18.01.2022.
//  Copyright © 2022 Finch. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Public Methods
    
    func disableAutoresizingMaskForViews(_ views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
}
