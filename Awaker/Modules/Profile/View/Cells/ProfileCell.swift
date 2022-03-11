//
//  ProfileCell.swift
//  Awaker
//
//  Created by Ilya Turin on 11.03.2022.
//

import UIKit
import PureLayout

final class ProfileCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        titleLabel.textColor = .blue
        
        contentView.addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges()
    }
    
}


// MARK: - Configurable
extension ProfileCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        
        titleLabel.text = model.title
    }
}
