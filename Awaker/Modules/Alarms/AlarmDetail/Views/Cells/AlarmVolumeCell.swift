//
//  AlarmVolumeCell.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit
import PureLayout
import RxSwift
import RxCocoa

final class AlarmVolumeCell: CellWithSpacing {
    
    // MARK: - Properties
    
    private var disposeBag: DisposeBag?
    
    private let titleLabel = UILabel()
    private let slider = UISlider()
    
    
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
        contentView.addSubview(slider)
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0),
                                                excludingEdge: .right)
        
        slider.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16),
                                            excludingEdge: .left)
        
        slider.autoPinEdge(.left, to: .right, of: titleLabel, withOffset: 20)
    }
    
}

extension AlarmVolumeCell: Configurable {
    
    struct Model {
        
        let title: String
        let sliderValue: PublishSubject<Float>
    }
    
    func configure(with model: Model) {
        
        let disposeBag = DisposeBag()
        
        titleLabel.text = model.title
    
        slider.rx.value
            .bind(to: model.sliderValue)
            .disposed(by: disposeBag)
        
        self.disposeBag = disposeBag
    }
    
}
