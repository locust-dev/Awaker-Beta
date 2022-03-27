//
//  AlarmRepeatDelayCell.swift
//  Awaker
//
//  Created by Ilya Turin on 22.03.2022.
//

import UIKit
import PureLayout
import RxSwift

final class AlarmRepeatDelayCell: CellWithSpacing {
    
    // MARK: - Properties
    
    private var disposeBag: DisposeBag?
    
    private let titleLabel = UILabel()
    private let timePicker = AlarmRepeatDelayPicker()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        titleLabel.text = "Повтор сигнала"
        titleLabel.font = MainFont.regular.withSize(14)
        titleLabel.textColor = .white
    
        contentView.backgroundColor = .white.withAlphaComponent(0.15)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(titleLabel)
        contentView.addSubview(timePicker)
        
        timePicker.autoSetDimension(.width, toSize: 100)
        timePicker.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16),
                                                excludingEdge: .left)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0),
                                                excludingEdge: .right)
    }
    
}

extension AlarmRepeatDelayCell: Configurable {
    
    struct Model {
        
        let repeatDelay: BehaviorSubject<Int?>
    }
    
    func configure(with model: Model) {
        
        let disposeBag = DisposeBag()
        
        timePicker.selectedDelay
            .bind(to: model.repeatDelay)
            .disposed(by: disposeBag)
        
        self.disposeBag = disposeBag
    }
}
