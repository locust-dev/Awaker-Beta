//
//  AlarmCell.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 11.03.2022.
//

import UIKit
import PureLayout

final class AlarmCell: NLTableViewCell {
    
    // MARK: - Properties
    
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let switcher = UIButton()
    let weeklyView = UIView()
    let iconImageView = UIImageView()
    
    private var switcherIsOn = false {
        didSet {
            switcher.setImage(switcherIsOn ? Images.switchOn() : Images.switchOff(), for: .normal)
        }
    }
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        let containerView = UIView()
        containerView.backgroundColor = .purple.withAlphaComponent(0.1)
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)
        
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 20)
        containerView.addSubview(nameLabel)
        
        timeLabel.textColor = .white
        timeLabel.font = .systemFont(ofSize: 36)
        containerView.addSubview(timeLabel)
        
        containerView.addSubview(switcher)
        switcher.setImage(Images.switchOff(), for: .normal)
        switcher.autoPinEdge(toSuperviewEdge: .right, withInset: 64)
        switcher.autoSetDimensions(to: CGSize(width: 42, height: 42))
        switcher.autoAlignAxis(toSuperviewAxis: .horizontal)
        switcher.addTarget(self, action: #selector(didTapSwitcher), for: .touchUpInside)
        
        
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8,
                                                                      left: 16,
                                                                      bottom: 8,
                                                                      right: 16))
        
        nameLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20,
                                                                  left: 16,
                                                                  bottom: 0,
                                                                  right: 16),
                                               excludingEdge: .bottom)
        
        timeLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        timeLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        timeLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapSwitcher() {
        switcherIsOn = !switcherIsOn
    }
    
}


// MARK: - Configurable
extension AlarmCell: Configurable {
    
    struct Model {
        let name: String
    }
    
    func configure(with model: Model) {
        nameLabel.text = model.name
    }
    
}
