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
    
    private var controllers = [UIViewController]()
    
    let tabBarViewModel = TabBarViewModel()
    
    private let disposeBag = DisposeBag()
   
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSubscriptions()
        tabBarViewModel.configureModules()
    }
    
    
    // MARK: - Setup
    
    private func setupSubscriptions() {
        
        tabBarViewModel.modules.subscribe { moduleType in
            switch moduleType {
                
            case .alarms:
                self.setupAlarmsModule()
                
            case .profile:
                self.setupProfileModule()
            }
            
        } onCompleted: {
            self.viewControllers = self.controllers
            
        }.disposed(by: disposeBag)
    }
    
    
    // MARK: - Private methods
    
    private func setupAlarmsModule() {
        
        let module = AlarmsViewController()
        controllers.append(module)
    }
    
    private func setupProfileModule() {
        
        let module = ProfileViewController()
        controllers.append(module)
    }
    
}
