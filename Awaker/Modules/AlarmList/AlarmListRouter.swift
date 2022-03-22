//
//  AlarmListRouter.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 22.03.2022.
//

protocol AlarmListRouterInput {
    func openAlarmDetail(name: String)
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
    
    func openAlarmDetail(name: String) {
        let viewModel = AlarmDetailViewModel()
        let view = AlarmDetailViewController()
        view.viewModel = viewModel
        transition.present(viewController: view, animated: true)
        viewModel.name.onNext(name)
    }
    
}
