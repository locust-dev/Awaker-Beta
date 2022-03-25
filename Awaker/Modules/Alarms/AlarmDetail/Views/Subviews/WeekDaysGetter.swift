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
    
    let selectedWeekDays = BehaviorSubject(value: WeekDay.workDays)
    
    private let weekDayDidChange: PublishSubject<WeekDay>
    private let weekDayViews: [WeekDayView]
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    init() {
        
        let weekDayDidChangeObserver = PublishSubject<WeekDay>()
        
        weekDayViews = WeekDay.allCases.map {
            WeekDayView(weekDay: $0, didChangeObserver: weekDayDidChangeObserver)
        }
        
        self.weekDayDidChange = weekDayDidChangeObserver
    }
    
    
    // MARK: - Public methods
    
    func startSubscribing() {
        
        weekDayDidChange
            .withLatestFrom(selectedWeekDays) { ($0, $1) }
            .subscribe(onNext: { [weak selectedWeekDays] changedDay, selectedDays in
                selectedDays.contains(changedDay)
                    ? selectedWeekDays?.onNext(selectedDays.filter({ $0 != changedDay }))
                    : selectedWeekDays?.onNext(selectedDays + [changedDay])
            })
            .disposed(by: disposeBag)
    }
    
}
