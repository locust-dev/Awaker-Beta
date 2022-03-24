//
//  ProfileViewController.swift
//  Awaker
//
//  Created by Ilya Turin on 09.03.2022.
//

import UIKit
import PureLayout
import RxSwift
import RxCocoa

final class ProfileViewController: NLViewController {
    
    // MARK: - Properties
    
    var viewModel: ProfileViewModel!
    
    private let selectedCell = PublishSubject<IndexPath>()
    private let tableView = CommonTableView()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        bind()
        viewModel.fetchProfileInfo()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
       
        tableView.refreshControlIsEnabled = true
        tableView.register(ProfileCell.self)
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    
    // MARK: - Setup
    
    private func bind() {
        
        let input = ProfileViewModel.Input(cellIndex: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.isLoading
            .drive(tableView.isLoading)
            .disposed(by: disposeBag)
        
        
        output.cellModel
            .drive(tableView.rx.items(cellIdentifier: ProfileCell.className, cellType: ProfileCell.self))
        { _, title, cell in
            let model = ProfileCell.Model(title: title)
            cell.configure(with: model)
            
        }.disposed(by: disposeBag)
    }
    
}
