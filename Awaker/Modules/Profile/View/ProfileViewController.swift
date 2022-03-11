//
//  ProfileViewController.swift
//  Awaker
//
//  Created by Ilya Turin on 09.03.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: NLViewController {
    
    // MARK: - Properties
    
    let viewModel = ProfileViewModel()
    
    private let tableView = CommonTableView()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        setupSubscriptions()
        viewModel.fetchProfileInfo()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
       
        tableView.register(ProfileCell.self)
        
        
        view.backgroundColor = .white
        view.addSubview(tableView)
       
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    
    // MARK: - Setup
    
    private func setupSubscriptions() {
        
        viewModel
            .isLoading
            .bind(to: tableView.isLoading)
            .disposed(by: disposeBag)
        
        viewModel
            .cellModel
            .bind(to: tableView.rx.items(cellIdentifier: ProfileCell.className, cellType: ProfileCell.self))
        { _, title, cell in
            let model = ProfileCell.Model(title: title)
            cell.configure(with: model)
            
        }.disposed(by: disposeBag)
    }
    
}
