//
//  WeekDayView.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit

final class WeekDayView: NLView {
    
    // MARK: - Properties
    
    var getWeekDay: WeekDay {
        weekDay
    }
    
    var isSelected: Bool {
        didSet {
            setSeleted()
        }
    }
    
    private let weekDay: WeekDay
    private let shortTitleLabel = UILabel()
    
    
    // MARK: - Init
    
    init(weekDay: WeekDay) {
        isSelected = weekDay.isWorkDay
        self.weekDay = weekDay
        super.init(frame: .zero)
        shortTitleLabel.text = weekDay.shortDayTitle
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        backgroundColor = isSelected ? .red : .purple
        
        shortTitleLabel.font = UIFont.systemFont(ofSize: 14)
        shortTitleLabel.textColor = .white
        shortTitleLabel.layer.cornerRadius = 12
        
        addSubview(shortTitleLabel)
        shortTitleLabel.autoPinEdgesToSuperviewEdges()
    }
    
    
    // MARK: - Actions
    
    @objc private func tap() {
        isSelected.toggle()
    }
    
    
    // MARK: - Privat methods
    
    private func setSeleted() {
        backgroundColor = isSelected ? .red : .purple
    }
}
