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

final class AlarmVolumeCell: NLTableViewCell {
    
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(slider)
        
        
        titleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        slider.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        titleLabel.autoPinEdge(.right, to: .left, of: slider)
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
