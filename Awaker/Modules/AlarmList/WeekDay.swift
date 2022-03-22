//
//  WeekDay.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 11.03.2022.
//

enum WeekDay: CaseIterable {
    
    static var allCases: [WeekDay] = [.sunday(),
                                      .monday(),
                                      .tuesday(),
                                      .wednesday(),
                                      .thursday(),
                                      .friday(),
                                      .saturday()]
    
    case sunday(isActive: Bool = false)
    case monday(isActive: Bool = false)
    case tuesday(isActive: Bool = false)
    case wednesday(isActive: Bool = false)
    case thursday(isActive: Bool = false)
    case friday(isActive: Bool = false)
    case saturday(isActive: Bool = false)
}
