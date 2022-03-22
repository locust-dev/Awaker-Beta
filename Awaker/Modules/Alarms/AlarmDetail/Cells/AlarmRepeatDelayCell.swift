//
//  AlarmRepeatDelayCell.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit
import PureLayout

final class AlarmRepeatDelayCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
    
        contentView.addSubview(titleLabel)
        
        
    }
    
}
