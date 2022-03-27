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
    private let navigationSubtitle = UILabel()
    
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
        
        output?.subtitle
            .drive(navigationSubtitle.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func drawSelf() {
        
        drawNavigationBar()
        
        view.backgroundColor = Colors.darkPurple()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(AlarmCell.self)
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    private func drawNavigationBar() {
        
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationTitle.font = MainFont.semiBold.withSize(18)
        navigationTitle.textColor = .white
        
        navigationSubtitle.font = MainFont.light.withSize(16)
        navigationSubtitle.textColor = .white
        
        navigationController?.navigationBar.addSubview(navigationTitle)
        navigationController?.navigationBar.addSubview(navigationSubtitle)
        
        navigationTitle.autoPinEdge(toSuperviewEdge: .top)
        navigationTitle.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        navigationSubtitle.autoPinEdge(.top, to: .bottom, of: navigationTitle)
        navigationSubtitle.autoPinEdge(.left, to: .left, of: navigationTitle)
        navigationSubtitle.autoPinEdge(toSuperviewEdge: .bottom)
        
    }
}
