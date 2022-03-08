//
//  UIViewController+Modal.swift
//  SberSound
//
//  Created by Konstantin Poznyak on 27.07.2021.
//  Copyright © 2021 FINCH. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Properties
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentedViewController = navigationController?.presentingViewController?.presentedViewController
        let presentingIsNavigation = presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
}
