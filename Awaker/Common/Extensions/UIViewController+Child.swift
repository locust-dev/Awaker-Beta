//
//  UIViewController+Child.swift
//  Awaker
//
//  Created by Ilya Turin on 10.03.2022.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController,to parentView:UIView) {
        addChild(child)
        parentView.addSubview(child.view)
        child.view.frame = parentView.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
