//
//  UIViewController + Navigation.swift
//  FinchExtensions
//
//  Created by VadimQw  on 16.09.2021.
//  Copyright © 2021 Finch Mobile. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Types
    
    enum SideType {
        case right
        case left
    }
    
    
    // MARK: - Public methods
    
    func getNavigationBarButtonView(forSide side: SideType) -> UIView? {
        
        guard let subviews = navigationController?.navigationBar.subviews else {
            return nil
        }
        
        for view in subviews {
            if let findClass = NSClassFromString("_UINavigationBarContentView"),
               view.isKind(of: findClass),
               let buttonView = navigationBarButtonView(forSide: side) {
                
                return buttonView
            }
        }

        return nil
    }
    

    // MARK: - Private methods
    
    private func navigationBarButtonView(forSide side: SideType) -> UIView? {
        
        let key = "view"
        switch side {
        
        case .left:
            return navigationItem.leftBarButtonItem?.value(forKey: key) as? UIView
        
        case .right:
            return navigationItem.rightBarButtonItem?.value(forKey: key) as? UIView
        }
    }
    
}
