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
    
    let cells = PublishSubject<[AlarmModel]>()
    let selectedAlarmModel = PublishSubject<AlarmModel>()
    
    let disposeBag = DisposeBag()
    
    private let names = ["рукоблуд", "ссанина", "очко", "блядун", "вагина"]
    
    
    // MARK: - Public methods
    
    func transform(input: Input) -> Output {
        
        
        
        return Output(cellModels: cells.asDriver(onErrorJustReturn: []))
    }
    
    func fetchCellNames() {
        let alarmModels = names.map { AlarmModel(name: $0)}
        cells.onNext(alarmModels)
    }
    
}

extension AlarmListViewModel {
    
    struct Input {
        let selectedCellIndex: Driver<IndexPath>
    }
    
    struct Output {
        let cellModels: Driver<[AlarmModel]>
    }
    
}
