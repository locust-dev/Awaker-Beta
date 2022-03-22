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
    
    // MARK: - Properties
    
    var viewModel: AlarmDetailViewModel!
    
    private let mainTitleTextView = UITextView()
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
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
    
        tableView.register([
            AlarmTitleCell.self,
            AlarmVolumeCell.self,
            AlarmRepeatDelayCell.self
        ])
        
        view.setGradientBackground(
            with: [Colors.lightPurple(), Colors.darkPurple()],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 0)
        )
        
        let daysStack = UIStackView(arrangedSubviews: WeekDay.allCases.map { WeekDayView(weekDay: $0) })
        daysStack.spacing = 12
        daysStack.distribution = .fillEqually
        
        pickerView.datePickerMode = .time
        pickerView.locale = Locale(identifier: "en_GB")
        pickerView.preferredDatePickerStyle = .wheels
        
        mainTitleTextView.isScrollEnabled = false
        mainTitleTextView.backgroundColor = .clear
        mainTitleTextView.textColor = .white
        mainTitleTextView.text = "Новый будильник..."
        mainTitleTextView.font = UIFont.systemFont(ofSize: 18)
        
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.setTitle("Х", for: .normal)
        closeButton.backgroundColor = .yellow
        
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .white
        
        view.addSubview(mainTitleTextView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        view.addSubview(pickerView)
        view.addSubview(tableView)
        view.addSubview(daysStack)
        
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        closeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        closeButton.autoSetDimensions(to: CGSize(width: 22, height: 22))
        
        saveButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        saveButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        saveButton.autoSetDimensions(to: CGSize(width: 100, height: 22))
        
        mainTitleTextView.autoPinEdge(.top, to: .bottom, of: closeButton, withOffset: 30)
        mainTitleTextView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        mainTitleTextView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        pickerView.autoPinEdge(.top, to: .bottom, of: mainTitleTextView, withOffset: 30)
        pickerView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        pickerView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        pickerView.autoSetDimension(.height, toSize: 150)
        
        daysStack.autoPinEdge(.top, to: .bottom, of: pickerView, withOffset: 20)
        daysStack.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        daysStack.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
        tableView.autoPinEdge(.top, to: .bottom, of: daysStack)
        tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
    }
    
    
    // MARK: - Private methods
    
    private func bind() {
        
        let input = AlarmDetailViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        
        
    }
    
}
