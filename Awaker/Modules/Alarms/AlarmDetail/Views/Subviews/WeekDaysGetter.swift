//
//  WeekDaysGetter.swift
//  Awaker
//
//  Created by Ilya Turin on 24.03.2022.
//

import RxSwift

final class WeekDaysGetter {
    
    // MARK: - Properties
    
    var allWeekDayViews: [WeekDayView] {
        weekDayViews
    }
    
    let selectedWeekDays: Observable<[WeekDayView]>
    
    private let weekDayViews: [WeekDayView]
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    init() {
        let weekDayViews = WeekDay.allCases.map { WeekDayView(weekDay: $0) }
        self.weekDayViews = weekDayViews
        self.selectedWeekDays = Observable.just(weekDayViews)
    }
    
}
