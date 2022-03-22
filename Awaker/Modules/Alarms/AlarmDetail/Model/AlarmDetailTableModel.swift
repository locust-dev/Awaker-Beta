//
//  AlarmDetailTableModel.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

enum AlarmDetailTableModel: CaseIterable {
    
    case volume
    case sound
    case task
    case repeatDelay
    
    var title: String {
        
        switch self {
            
        case .volume:
            return "Громкость"
            
        case .sound:
            return "Мелодия"
            
        case .task:
            return "Задача"
            
        case .repeatDelay:
            return "Повтор сигнала"
        }
    }
}
