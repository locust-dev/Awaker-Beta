//
//  AlarmTitleCell.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit
import PureLayout

import RxSwift
import RxCocoa

final class AlarmTitleCell: CellWithSpacing {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private var disposeBag: DisposeBag?
    
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = nil
    }
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        titleLabel.font = MainFont.regular.withSize(14)
        titleLabel.textColor = .white
    
        contentView.backgroundColor = .white.withAlphaComponent(0.15)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
}

extension AlarmTitleCell: Configurable {
    
    struct Model {
        
        let title: String
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
    }
}
