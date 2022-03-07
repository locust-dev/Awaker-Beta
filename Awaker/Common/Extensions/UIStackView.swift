//
//  UIStackView.swift
//  Questionnaire
//
//  Created by Ilya Turin on 14.12.2021.
//

import UIKit

extension UIStackView {
    
    // Позволяет удалять сабвью полностью, не оставляя их в памяти
    
    func removeSubviewFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeAllArrangedSubviewsFully() {
        arrangedSubviews.forEach { (view) in
            removeSubviewFully(view: view)
        }
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach({ addArrangedSubview($0) })
    }
}
