//
//  WeekDayView.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit

final class WeekDayView: NLView {
    
    // MARK: - Properties
    
    private let shortTitleLabel = UILabel()
    
    
    // MARK: - Init
    
    init(weekDay: WeekDay) {
        super.init(frame: .zero)
        shortTitleLabel.text = weekDay.shortDayTitle
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .white
        
        shortTitleLabel.font = UIFont.systemFont(ofSize: 14)
        shortTitleLabel.textColor = .black
        shortTitleLabel.layer.cornerRadius = 12
        
        addSubview(shortTitleLabel)
        
        shortTitleLabel.autoPinEdgesToSuperviewEdges()
    }
    
}
