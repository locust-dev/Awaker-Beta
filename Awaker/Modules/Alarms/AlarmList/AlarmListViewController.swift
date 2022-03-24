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
    
    private func bind() {
        
        let input = AlarmListViewModel.Input(selectedCellIndex: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel?.transform(input: input)
        
        output?.cellModels.drive(tableView.rx.items(cellIdentifier: AlarmCell.className,
                                                    cellType: AlarmCell.self)) { _, model, cell in
            cell.nameLabel.text = model.name
            cell.timeLabel.text = model.time.dateStringWithFormat(.minHours)
            
        }.disposed(by: disposeBag)
    }
    
    private func drawSelf() {
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = Colors.darkPurple()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(AlarmCell.self)
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewEdges()
    }
}
