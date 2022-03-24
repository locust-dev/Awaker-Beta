//
//  AlarmCell.swift
//  Awaker
//
//  Created by Эльдар Гашимов on 11.03.2022.
//

import UIKit
import PureLayout

import RxSwift
import RxCocoa

final class AlarmCell: NLTableViewCell {
    
    // MARK: - Properties
    
    let containerView = UIView()
    
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let switcher = UIButton()
    let weeklyView = WeeklyView()
    let iconImageView = UIImageView()
    
//    private var isActive: Bool = false {
//        didSet {
//            if isActive {
//                containerView.alpha = 1
//                switcher.tintColor = Colors.neon()
//                switcher.turnOnBacklight(Colors.neon())
//            } else {
//                containerView.alpha = 0.7
//                switcher.tintColor = .white
//                switcher.turnOffBacklight()
//            }
//        }
//    }
    
    private var disposeBag: DisposeBag?
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = Colors.lightPurple()
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        containerView.alpha = 0.7
        contentView.addSubview(containerView)
        
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        containerView.addSubview(nameLabel)
        
        timeLabel.textColor = .white
        timeLabel.font = .systemFont(ofSize: 26, weight: .bold)
        containerView.addSubview(timeLabel)
        
        containerView.addSubview(weeklyView)
        
        iconImageView.image = Images.steps()
        iconImageView.tintColor = .white
        containerView.addSubview(iconImageView)
        
        containerView.addSubview(switcher)
        switcher.setImage(Images.switchOff(), for: .normal)
        switcher.tintColor = .white
        
        switcher.autoPinEdge(.right, to: .left, of: iconImageView, withOffset: -20)
        switcher.autoSetDimensions(to: CGSize(width: 42, height: 42))
        switcher.autoAlignAxis(toSuperviewAxis: .horizontal)
//        switcher.addTarget(self, action: #selector(didTapSwitcher), for: .touchUpInside)
        
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8,
                                                                      left: 16,
                                                                      bottom: 8,
                                                                      right: 16))
        
        nameLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20,
                                                                  left: 16,
                                                                  bottom: 0,
                                                                  right: 16),
                                               excludingEdge: .bottom)
        
        timeLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
        timeLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        
        weeklyView.autoPinEdge(.top, to: .bottom, of: timeLabel, withOffset: 8)
        weeklyView.autoPinEdge(.left, to: .left, of: timeLabel)
        weeklyView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        
        iconImageView.autoSetDimensions(to: CGSize(width: 24, height: 24))
        iconImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 12)
        iconImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
    }
    
//    @objc private func didTapSwitcher() {
//        isActive = !isActive
//    }
    
    func bind(to viewModel: AlarmListViewModel?) {
        
    }
    
}
