//
//  WeekDay.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

enum WeekDay: CaseIterable {
    
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var shortDayTitle: String {
        
        // TODO: - Локализовать
        
        switch self {
            
        case .sunday:
            return "ВС"
            
        case .monday:
            return "ПН"
            
        case .tuesday:
            return "ВТ"
            
        case .wednesday:
            return "СР"
        
        case .thursday:
            return "ЧТ"
            
        case .friday:
            return "ПТ"
            
        case .saturday:
            return "СБ"
        }
    }
    
}
