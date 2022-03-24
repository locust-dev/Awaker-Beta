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
    
    let cells = PublishSubject<[Alarm]>()
    
    let disposeBag = DisposeBag()
    
    private let names = ["рукоблуд", "ссанина", "очко", "блядун", "вагина"]
    
    
    // MARK: - Public methods
    
    func transform(input: Input) -> Output {
        input.selectedCellIndex
            .drive(onNext: { indexPath in
                self.router?.openAlarmDetail(name: self.names[safe: indexPath.row] ?? "")
            })
            .disposed(by: disposeBag)
        return Output(cellModels: cells.asDriver(onErrorJustReturn: []))
    }
    
    func fetchCellNames() {
        let alarmModels = names.map { Alarm(name: $0,
                                            time: Date(),
                                            activeDays: [],
                                            terminateMethod: nil,
                                            volume: 0,
                                            sound: "",
                                            repeatDelay: 0)
        }
        
        cells.onNext(alarmModels)
    }
    
}

extension AlarmListViewModel {
    
    struct Input {
        let selectedCellIndex: Driver<IndexPath>
    }
    
    struct Output {
        let cellModels: Driver<[Alarm]>
    }
    
}
