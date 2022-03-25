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
    private let alarmNameTextView = UITextView()
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    private let pickerView = UIDatePicker()
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
            AlarmTitleCell.self,
            AlarmVolumeCell.self,
            AlarmRepeatDelayCell.self
        ])
        
        view.backgroundColor = UIColor(hex: Locals.mainBackground)
        
        let daysStack = UIStackView(arrangedSubviews: weekDayGetter.allWeekDayViews)
        daysStack.spacing = 12
        daysStack.distribution = .fillEqually
        
        pickerView.datePickerMode = .time
        pickerView.locale = Locale(identifier: "en_GB")
        pickerView.preferredDatePickerStyle = .wheels
        
        alarmNameTextView.isScrollEnabled = false
        alarmNameTextView.backgroundColor = .clear
        alarmNameTextView.textColor = .white
        alarmNameTextView.font = UIFont.systemFont(ofSize: 18)
        
      //  closeButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        closeButton.layer.cornerRadius = 8
        closeButton.backgroundColor = .white.withAlphaComponent(0.15)
        closeButton.setTitleColor(.black, for: .normal)
        
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .white.withAlphaComponent(0.15)
        saveButton.setTitleColor(.black, for: .normal)
        
        view.addSubview(alarmNameTextView)
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
        
        alarmNameTextView.autoPinEdge(.top, to: .bottom, of: closeButton, withOffset: 30)
        alarmNameTextView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        alarmNameTextView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        pickerView.autoPinEdge(.top, to: .bottom, of: alarmNameTextView, withOffset: 30)
        pickerView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        pickerView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        pickerView.autoSetDimension(.height, toSize: 150)
        
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
            name: alarmNameTextView.rx.text.asObservable(),
            time: pickerView.rx.value.asObservable(),
            activeDays: weekDayGetter.selectedWeekDays.asObservable(),
            
            // TODO: - Доделать и додумать
            terminateMethod: Observable.just(nil),
            sound: Observable.just("новый звук"),
            
            closeButtonTap: closeButton.rx.tap.asDriver(),
            saveButtonTap: saveButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        output.initialAlarmName
            .drive(onNext: { self.alarmNameTextView.rx.text.onNext($0) })
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
