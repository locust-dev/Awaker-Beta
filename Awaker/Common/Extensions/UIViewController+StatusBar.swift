//
//  UIViewController+StatusBar.swift
//  Questionnaire
//
//  Created by Ilya Turin on 19.12.2021.
//

import UIKit

extension UIViewController {
    
    func getStatusBarHeight() -> CGFloat {
        let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        return window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    }
}
