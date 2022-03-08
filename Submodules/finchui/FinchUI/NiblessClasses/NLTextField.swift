//
//  NLTextField.swift
//  FinchUI
//
//  Created by VadimQw  on 25.08.2021.
//  Copyright © 2021 Potapov Anton. All rights reserved.
//

import UIKit

class NLTextField: UITextField { // swiftlint:disable:this final_class
    
    // MARK: - Init
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Loading this text field from a nib is unsupported in favor of initializer dependency injection.") // swiftlint:disable:this line_length
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this text field from a nib is unsupported in favor of initializer dependency injection.")
    }
    
}
