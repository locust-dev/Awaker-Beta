//
//  AlarmListRouter.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 22.03.2022.
//

import RxSwift

protocol AlarmListRouterInput {
    func openAlarmDetail(newAlarm: PublishSubject<Alarm>)
    func openAlarmDetail(with alarm: Alarm)
}

final class AlarmListRouter {
    
    // MARK: - Properties
    
    private unowned let transition: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transition: ModuleTransitionHandler) {
        self.transition = transition
    }
    
}


// MARK: - AlarmListRouterInput
extension AlarmListRouter: AlarmListRouterInput {
    
    func openAlarmDetail(newAlarm: PublishSubject<Alarm>) {
        
        let viewModel = AlarmDetailViewModel()
        viewModel.newAlarm = newAlarm
        let view = AlarmDetailViewController()
        let router = AlarmDetailRouter(view: view)
        
        view.viewModel = viewModel
        viewModel.router = router
        
        transition.present(viewController: view, animated: true)
    }
    
    func openAlarmDetail(with alarm: Alarm) {
        
        let viewModel = AlarmDetailViewModel(alarm: alarm)
        let view = AlarmDetailViewController()
        let router = AlarmDetailRouter(view: view)
        
        view.viewModel = viewModel
        viewModel.router = router
        
        transition.present(viewController: view, animated: true)
    }
}
