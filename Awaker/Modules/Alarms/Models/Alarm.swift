//
//  Alarm.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import Foundation

struct Alarm {
    
    typealias Sound = String
    
    let name: String
    
    /// Время пробуждения в формате 00 : 00
    let time: Date
    
    /// Если true - хотя бы в один из дней будильник будет повторяться
    let activeDays: [WeekDay]?
    let terminateMethod: TerminateMethod?
    let volume: Float
    let sound: Sound
    
    /// Отложить будильник в минутах
    let repeatDelay: Int
}
