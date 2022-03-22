//
//  AppCoordinator.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 19.03.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        let viewModel = AlarmListViewModel()
        viewModel.coordinator = self
        let view = AlarmListViewController()
        view.viewModel = viewModel
        navigationController.viewControllers = [view]
    }
    
    func openAlarmDetailScreen(name: String) {
        let viewModel = AlarmDetailViewModel()
        let view = AlarmDetailViewController()
        view.viewModel = viewModel
        navigationController.pushViewController(view, animated: true)
        viewModel.name.onNext(name)
    }
    
}
