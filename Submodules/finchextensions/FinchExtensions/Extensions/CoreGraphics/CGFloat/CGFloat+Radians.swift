//
//  CGFloat+Radians.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 30.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    
    // MARK: - Public methods
    
    /// Возвращает текущее значение в радианах
    func toRadians() -> CGFloat {
        self * .pi / 180
    }
    
}
