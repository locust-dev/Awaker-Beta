//
//  AlarmListViewController.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 11.03.2022.
//

import UIKit
import PureLayout

import RxSwift
import RxCocoa


final class AlarmListViewController: NLViewController {
    
    // MARK: - Properties
    
    var viewModel: AlarmListViewModel?
    
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        bind()
        viewModel?.fetchCellNames()
    }
    
    private func drawSelf() {
        
        view.setGradientBackground(with: [Colors.darkPurple(), Colors.lightPurple()])
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(AlarmCell.self)
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    private func bind() {
        
        let input = AlarmListViewModel.Input(selectedCellIndex: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel?.transform(input: input)
        
        output?.cellModels.drive(tableView.rx.items(cellIdentifier: AlarmCell.className,
                                                    cellType: AlarmCell.self)) { _, model, cell in
            let model = AlarmCell.Model(name: model.name)
            cell.configure(with: model)
        }.disposed(by: disposeBag)
    }
}
