//
//  UIStackView+AddArrangedSubviews.swift
//  Stoloto
//
//  Created by Arcani on 18.01.2022.
//  Copyright © 2022 Finch. All rights reserved.
//

import UIKit

extension UIStackView {
    
    // MARK: - Public Methods
    
        func addMultipleViewsToStack(_ views: UIView...) {
            views.forEach { addArrangedSubview($0) }
        }
    
}
