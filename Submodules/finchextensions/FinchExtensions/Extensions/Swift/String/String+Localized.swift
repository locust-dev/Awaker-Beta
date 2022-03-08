//
//  String+Localized.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 31.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: Properties
    
    /// Возврашает локализованную строку
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
}
