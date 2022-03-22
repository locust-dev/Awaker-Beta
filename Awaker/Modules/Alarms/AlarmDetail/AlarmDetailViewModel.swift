//
//  AlarmDetailViewModel.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 19.03.2022.
//

import RxSwift
import RxCocoa

final class AlarmDetailViewModel {
    
    // MARK: - Properties
    
    private let cells = Observable.from([AlarmDetailTableModel.allCases])
    private let bag = DisposeBag()
    
    
    func configureCells() {
        
        
    }
}


//MARK: - ViewModelType
extension AlarmDetailViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let cells: Driver<[AlarmDetailTableModel]>
    }
    
    func transform(input: Input) -> Output {
        
      

        
        return Output(cells: cells.asDriver(onErrorJustReturn: []))
    }
    
}
