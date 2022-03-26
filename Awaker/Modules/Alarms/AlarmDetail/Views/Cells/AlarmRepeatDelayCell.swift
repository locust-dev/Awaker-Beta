//
//  AlarmRepeatDelayCell.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit
import PureLayout

final class AlarmRepeatDelayCell: CellWithSpacing {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        titleLabel.text = "Повтор сигнала (в разработке)"
        titleLabel.font = MainFont.regular.withSize(14)
        titleLabel.textColor = .white
    
        contentView.backgroundColor = .white.withAlphaComponent(0.15)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
}

extension AlarmRepeatDelayCell: Configurable {
    
    struct Model {
        
        
    }
    
    func configure(with model: Model) {
        
    }
}
