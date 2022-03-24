//
//  WeeklyView.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 23.03.2022.
//

import UIKit
import PureLayout

final class WeeklyView: NLView {
    
    // MARK: - Properties
    
    private let mondayLabel = UILabel()
    private let tuesdayLabel = UILabel()
    private let wensdayLabel = UILabel()
    private let thursdayLabel = UILabel()
    private let fridayLabel = UILabel()
    private let saturdayLabel = UILabel()
    private let sundayLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        addSubview(stackView)

        stackView.autoPinEdgesToSuperviewEdges()
        stackView.addArrangedSubviews([mondayLabel,
                                       tuesdayLabel,
                                       wensdayLabel,
                                       thursdayLabel,
                                       fridayLabel,
                                       saturdayLabel,
                                       sundayLabel])
        
        mondayLabel.text = "пн"
        tuesdayLabel.text = "вт"
        wensdayLabel.text = "ср"
        thursdayLabel.text = "чт"
        fridayLabel.text = "пт"
        saturdayLabel.text = "сб"
        sundayLabel.text = "вс"
        
        [mondayLabel,
         tuesdayLabel,
         wensdayLabel,
         thursdayLabel,
         fridayLabel,
         saturdayLabel,
         sundayLabel].forEach {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 18, weight: .light)
            $0.textAlignment = .center
        }
    }
    
}
