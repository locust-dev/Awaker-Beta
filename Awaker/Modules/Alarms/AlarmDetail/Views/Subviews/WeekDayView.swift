//
//  WeekDayView.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit

import RxSwift

final class WeekDayView: NLView {
    
    // MARK: - Properties
    
    var getWeekDay: WeekDay {
        weekDay
    }
    
    var isSelected: Bool = false {
        didSet {
             setSeleted()
        }
    }
    
    private let viewDidChange: PublishSubject<WeekDay>
    private let weekDay: WeekDay
    private let shortTitleLabel = UILabel()
    
    
    // MARK: - Init
    
    init(weekDay: WeekDay,
         didChangeObserver: PublishSubject<WeekDay>) {
        
        viewDidChange = didChangeObserver
        self.weekDay = weekDay
        super.init(frame: .zero)
        shortTitleLabel.text = weekDay.shortDayTitle
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        shortTitleLabel.textAlignment = .center
        shortTitleLabel.font = MainFont.regular.withSize(20)
        shortTitleLabel.textColor = isSelected ? UIColor(hex: "#9E75EE") : .white
        
        addSubview(shortTitleLabel)
        shortTitleLabel.autoPinEdgesToSuperviewEdges()
    }
    
    
    // MARK: - Actions
    
    @objc private func tap() {
        viewDidChange.onNext(weekDay)
    }
    
    
    // MARK: - Privat methods
    
    private func setSeleted() {
        shortTitleLabel.font = isSelected ? MainFont.regular.withSize(22) : MainFont.regular.withSize(20)
        shortTitleLabel.textColor = isSelected ? UIColor(hex: "#9E75EE") : .white
    }
}
