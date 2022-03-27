//
//  Date+hour.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 27.03.2022.
//

import Foundation

extension Date {
    
    var hour: Int? {
        Calendar.current.dateComponents(in: .current, from: self).hour
    }
    
}
