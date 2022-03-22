//
//  AlarmDetailViewModel.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 19.03.2022.
//

import RxSwift
import RxCocoa

final class AlarmDetailViewModel {
    
    let name = BehaviorSubject<String>(value: "error")
    
    func transform(input: Input) -> Output {
        Output(name: name.asDriver(onErrorJustReturn: "error"))
    }
    
}

extension AlarmDetailViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        let name: Driver<String>
    }
    
}
