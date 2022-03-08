//
//  NLPageViewController.swift
//  FinchUI
//
//  Created by VadimQw  on 25.08.2021.
//  Copyright © 2021 Potapov Anton. All rights reserved.
//

import UIKit

class NLPageViewController: UIPageViewController { // swiftlint:disable:this final_class
    
    // MARK: - Init
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        
        super.init(
            transitionStyle: style,
            navigationOrientation: navigationOrientation,
            options: options
        )
    }
    
    @available(*, unavailable, message: "Loading this controller from a nib is unsupported in favor of initializer dependency injection.") // swiftlint:disable:this line_length
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
}
