//
//  Alarm.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import Foundation

typealias Sound = String

struct Alarm {
    
    var name: String?
    
    /// Время пробуждения в формате 00 : 00
    var time: Date
    
    /// Если true - хотя бы в один из дней будильник будет повторяться
    var activeDays: [WeekDay]
    var terminateMethod: TerminateMethod?
    var volume: Float
    var sound: Sound
    
    /// Отложить будильник в минутах, если nil то без откладывания
    var repeatDelay: Int?
}


// MARK: - Default alarm init
extension Alarm {
    
    init() {
        name = "Новый будильник"
        time = Date(timeIntervalSince1970: TimeInterval(124135))
        activeDays = []
        terminateMethod = nil
        volume = 0.5
        sound = "Какой то звук"
        repeatDelay = 5
    }
}
