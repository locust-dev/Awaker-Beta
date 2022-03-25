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
    
    private let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                     target: self,
                                                     action: nil)
    
    private let navigationTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        bind()
    }
    
    private func bind() {
        
        let input = AlarmListViewModel.Input(selectedCellIndex: tableView.rx.itemSelected.asDriver(),
                                             addButtonTap: rightBarButtonItem.rx.tap.asDriver())
        
        let output = viewModel?.transform(input: input)
        
        output?.cellModels.drive(tableView.rx.items(cellIdentifier: AlarmCell.className,
                                                    cellType: AlarmCell.self)) { _, model, cell in
            cell.nameLabel.text = model.name
            cell.timeLabel.text = model.time.dateStringWithFormat(.minHours)
            cell.weeklyView.setActiveDays(model.activeDays)
            
        }.disposed(by: disposeBag)
        
        output?.title
            .drive(navigationTitle.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func drawSelf() {
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationTitle.font = .systemFont(ofSize: 18, weight: .regular)
        navigationTitle.textColor = .white
        
        navigationController?.navigationBar.addSubview(navigationTitle)
        
        navigationTitle.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0,
                                                                             left: 20,
                                                                             bottom: 0,
                                                                             right: 0),
                                                          excludingEdge: .right)
        
        view.backgroundColor = Colors.darkPurple()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(AlarmCell.self)
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewEdges()
    }
}
