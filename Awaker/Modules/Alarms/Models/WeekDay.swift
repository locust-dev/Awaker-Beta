//
//  WeekDay.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

enum WeekDay: CaseIterable {
    
    static var allCases: [WeekDay] = [.sunday,
                                      .monday,
                                      .thursday,
                                      .wednesday,
                                      .thursday,
                                      .friday,
                                      .saturday]
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
