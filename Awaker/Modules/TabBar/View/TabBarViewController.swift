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
    
    let tabBarViewModel = TabBarViewModel()
    
    private var controllers = [UIViewController]()
    
    private let disposeBag = DisposeBag()
   
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSubscriptions()
        tabBarViewModel.configureModules()
    }
    
    
    // MARK: - Setup
    
    private func setupSubscriptions() {
        
        tabBarViewModel.modules.subscribe {
            self.createModule($0)
        } onCompleted: {
            self.viewControllers = self.controllers
            self.controllers.removeAll()
        }.disposed(by: disposeBag)
    }
    
    
    // MARK: - Private methods
    
    private func createModule(_ moduleType: ModuleType) {
        
        let module: UIViewController
        let tabBarTitle: String
        
        switch moduleType {
            
        case .alarms:
            module = AlarmsViewController()
            tabBarTitle = "Alarms"
            
        case .profile:
            module = ProfileViewController()
            tabBarTitle = "Profile"
        }
        
        let navigationController = UINavigationController(rootViewController: module)
        navigationController.tabBarItem.title = tabBarTitle
        controllers.append(navigationController)
    }
    
}
