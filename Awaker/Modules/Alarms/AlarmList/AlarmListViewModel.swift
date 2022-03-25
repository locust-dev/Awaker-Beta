//
//  AlarmListViewModel.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 11.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class AlarmListViewModel {

    // MARK: - Properties

    var router: AlarmListRouterInput?
    
    let newAlarm = PublishSubject<Alarm>()
    
    var alarms: [Alarm] = []
    
    let cells = PublishSubject<[Alarm]>()
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Public methods
    
    func transform(input: Input) -> Output {
        input.selectedCellIndex
            .drive(onNext: { indexPath in
                if let alarm = self.alarms[safe: indexPath.row] {
                    self.router?.openAlarmDetail(with: alarm)
                }
            })
            .disposed(by: disposeBag)
        
        input.addButtonTap
            .drive(onNext: { [router] in
                router?.openAlarmDetail(newAlarm: self.newAlarm)
            })
            .disposed(by: disposeBag)
        
        newAlarm.subscribe {
            if let alarm = $0.element {
                self.alarms.append(alarm)
                self.alarms = self.alarms.sorted(by: {$0.time < $1.time})
                self.cells.onNext(self.alarms)
            }
        }.disposed(by: disposeBag)
        
        return Output(cellModels: cells.asDriver(onErrorJustReturn: []))
    }
    
}

extension AlarmListViewModel {
    
    struct Input {
        let selectedCellIndex: Driver<IndexPath>
        let addButtonTap: Driver<Void>
    }
    
    struct Output {
        let cellModels: Driver<[Alarm]>
    }
    
}
