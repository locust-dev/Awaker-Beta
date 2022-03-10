//
//  TabBarViewModel.swift
//  Awaker
//
//  Created by Ilya Turin on 09.03.2022.
//

import Foundation
import RxSwift

final class TabBarViewModel {
    
    // MARK: - Properties
    
    let modules = PublishSubject<ModuleType>()
    
    
    // MARK: - Public Methods
    
    func configureModules() {
        
        modules.onNext(ModuleType.alarms)
        modules.onNext(ModuleType.profile)
        modules.onCompleted()
    }
    
}
