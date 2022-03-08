//
//  UIView+.swift
//  Stoloto
//
//  Created by Arcani on 18.01.2022.
//  Copyright © 2022 Finch. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Public Methods
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
}
