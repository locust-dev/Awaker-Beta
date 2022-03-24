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

final class AlarmTitleCell: NLTableViewCell {
    
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
    
        contentView.addSubview(titleLabel)
        
        titleLabel.autoPinEdgesToSuperviewEdges()
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
