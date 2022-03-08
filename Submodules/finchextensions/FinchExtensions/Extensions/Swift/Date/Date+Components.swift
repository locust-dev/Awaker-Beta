//
//  Date+Components.swift
//  FinchExtensions
//
//  Created by Hrayr Yeghiazaryan on 27.05.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Component type
    
    enum DateComponentsType {
        case day, week, month, year
    }
    
    
    // MARK: - Format type
    
    enum DateFormat: String {
        
        case minHoursDayMMMMYearWhitespace = "HH:mm, dd MMMM yyyy"
        case yearMMDayDash = "yyyy-MM-dd"
        case dayMMMYearWhitespace = "dd MMM yyyy"
        case dayMMMMYearWhitespace = "dd MMMM yyyy"
        case dayMMYearDot = "dd.MM.yyyy"
        case weekday = "EE"
        case month = "MMM"
        case dayMMMM = "d MMMM"
        case dayMMMMDotYear = "dd MMMM, yyyy"
        case minHours = "HH:mm"
        case dayNumber = "d"
        
    }
    
    
    // MARK: - Properties
    
    /// Возвращает true, если день совпадает с текущим
    var isCurrentDate: Bool {
        
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        
        guard let dateToday = Calendar.current.date(from: today), self != dateToday else {
            return true
        }
        return false
    }
    
    /// Возвращает true, если день меньше текущиго
    var isLastDay: Bool {
        
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        
        guard let dateToday = Calendar.current.date(from: today), self >= dateToday else {
            return true
        }
        return false
    }
    
    
    // MARK: - Public methods
    
    /// Номер недели в году
    public var weekOfYear: Int? {
        Calendar.current.ordinality(of: .weekOfYear, in: .year, for: self)
    }
    
    /// Перевод cекунд в дату
    func secondsToDate(seconds: Double) -> Date {
        let milliseconds = seconds / 1000
        return Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
    
    /// Перевод timeIntervalSince1970 в дату
    func timeIntervalSince1970ToDate(seconds: Double) -> Date {
        Date(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    /// Возвращает текст исходя из даты с применением формата
    func dateStringWithFormat(_ format: DateFormat, locale: String = "ru_RU") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: self)
    }
    
    /// Возвращает разницу между двумя датами в часах
    func hours(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }
    
    /// Возвращает разницу между двумя датами в днях
    func days(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    /// Возвращает компоненты  разницы между двумя датами
    func differenceBetween(toDate: Date) -> DateComponents {
        let calendarComponents: Set<Calendar.Component> = [.day, .hour, .minute]
        let fromComponents = Calendar.current.dateComponents(calendarComponents, from: self)
        let toComponents = Calendar.current.dateComponents(calendarComponents, from: toDate)
        return Calendar.current.dateComponents(calendarComponents, from: fromComponents, to: toComponents)
    }
    
    /// Возвращает разницу между датами
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    /// Устанавливает день, неделю, месяц или год от текущей даты
    static func setupDateBy(type: DateComponentsType, quantity: Int, from date: Date = Date()) -> Date? {
        
        var components = DateComponents()
        
        switch type {
        
        case .day:
            components.day = quantity
            
        case .week:
            components.weekOfMonth = quantity
            
        case .month:
            components.month = quantity
            
        case .year:
            components.year = quantity
        }
        
        return Calendar.current.date(byAdding: components, to: date)
    }
    
}
