//
//  TabBarViewController.swift
//  Awaker
//
//  Created by Ilya Turin on 09.03.2022.
//

import UIKit
import RxSwift

final class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    let viewModel = TabBarViewModel()
    
    private var controllers = [UIViewController]()
    
    private let disposeBag = DisposeBag()
   
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSubscriptions()
        viewModel.configureModules()
    }
    
    
    // MARK: - Setup
    
    private func setupSubscriptions() {
        
        viewModel.modules.subscribe {
            self.createModule($0)
        } onCompleted: {
            self.viewControllers = self.controllers
            self.controllers.removeAll()
        }.disposed(by: disposeBag)
    }
    
    
    // MARK: - Private methods
    
    private func createModule(_ moduleType: ModuleType) {
        
        let module: UIViewController
        
        switch moduleType {
            
        case .alarms:
            module = AlarmListViewController()
            let router = AlarmListRouter(transition: module)
            let viewModel = AlarmListViewModel()
            viewModel.router = router
            (module as? AlarmListViewController)?.viewModel = viewModel
            
        case .profile:
            module = ProfileViewController()
        }
        
        let navigationController = UINavigationController(rootViewController: module)
        navigationController.tabBarItem.title = moduleType.title
        controllers.append(navigationController)
    }
    
}
