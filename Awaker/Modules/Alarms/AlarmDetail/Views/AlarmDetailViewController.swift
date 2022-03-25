//
//  AlarmDetailViewController.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 19.03.2022.
//

import UIKit
import PureLayout
import RxSwift
import RxCocoa

final class AlarmDetailViewController: NLViewController {
    
    private enum Locals {
        
        static let mainBackground = "#1A0837"
    }
    
    
    // MARK: - Properties
    
    var viewModel: AlarmDetailViewModel!
    
    private let weekDayGetter =  WeekDaysGetter()
    private let untilWakeUpLabel = UILabel()
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    private let pickerView = AlarmTimePicker()
    private let tableView = CommonTableView()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        bind()
        viewModel.createCells()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        weekDayGetter.startSubscribing()
        
        tableView.isScrollEnabled = false
        tableView.register([
            AlarmNameCell.self,
            AlarmTitleCell.self,
            AlarmVolumeCell.self,
            AlarmRepeatDelayCell.self
        ])
        
        view.backgroundColor = UIColor(hex: Locals.mainBackground)
        
        let daysStack = UIStackView(arrangedSubviews: weekDayGetter.allWeekDayViews)
        daysStack.spacing = 12
        daysStack.distribution = .fillEqually
        
        untilWakeUpLabel.textAlignment = .center
        untilWakeUpLabel.text = "Время сна ~ 7 ч 15 мин"
        untilWakeUpLabel.textColor = .white
        untilWakeUpLabel.font = UIFont.systemFont(ofSize: 24)
        
        closeButton.setImage(Images.closeButtonIcon(), for: .normal)
        closeButton.layer.cornerRadius = 8
        closeButton.backgroundColor = .white.withAlphaComponent(0.15)
        closeButton.setTitleColor(.black, for: .normal)
        
        saveButton.setImage(Images.checkMarkIcon(), for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .white.withAlphaComponent(0.15)
        saveButton.setTitleColor(.black, for: .normal)
        
        view.addSubview(untilWakeUpLabel)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        view.addSubview(pickerView)
        view.addSubview(tableView)
        view.addSubview(daysStack)
        
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        closeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        closeButton.autoSetDimensions(to: CGSize(width: 44, height: 44))
        
        saveButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        saveButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        saveButton.autoSetDimensions(to: CGSize(width: 44, height: 44))
        
        untilWakeUpLabel.autoPinEdge(.top, to: .bottom, of: closeButton, withOffset: 30)
        untilWakeUpLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        untilWakeUpLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        pickerView.autoPinEdge(.top, to: .bottom, of: untilWakeUpLabel, withOffset: 30)
        pickerView.autoPinEdge(toSuperviewEdge: .left, withInset: 30)
        pickerView.autoPinEdge(toSuperviewEdge: .right, withInset: 30)
        
        daysStack.autoPinEdge(.top, to: .bottom, of: pickerView, withOffset: 20)
        daysStack.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        daysStack.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        tableView.autoPinEdge(.top, to: .bottom, of: daysStack)
        tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        // TODO: - Разобраться
        tableView.autoSetDimension(.height, toSize: 200)
    }
    
    
    // MARK: - Private methods
    
    private func bind() {
        
        let input = AlarmDetailViewModel.Input(
            time: pickerView.selectedTime.asObservable(),
            activeDays: weekDayGetter.selectedWeekDays.asObservable(),
            terminateMethod: Observable.just(nil),   // TODO: - Доделать и додумать
            sound: Observable.just("новый звук"),
            closeButtonTap: closeButton.rx.tap.asDriver(),
            saveButtonTap: saveButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        output.alarm
            .subscribe(onNext: {
                self.pickerView.selectedTime.onNext($0.time)
                self.weekDayGetter.selectedWeekDays.onNext($0.activeDays)
            })
            .disposed(by: disposeBag)
        
        output.cells
            .drive(tableView.rx.items) { cell, index, model in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = self.tableView.dequeueReusableCell(withIdentifier: model.identifier, for: indexPath)
                model.configurator.configure(cell: cell)
                return cell
            }.disposed(by: disposeBag)
    }
    
}
