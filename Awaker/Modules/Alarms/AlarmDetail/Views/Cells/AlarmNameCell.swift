//
//  AlarmNameCell.swift
//  Awaker
//
//  Created by Ilya Turin on 25.03.2022.
//

import UIKit
import PureLayout

import RxSwift
import RxCocoa

final class AlarmNameCell: CellWithSpacing {
    
    // MARK: - Properties
    
    private let textField = UITextField()
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
        
        let cleanView = UIButton()
        cleanView.setImage(Images.closeButtonIcon(), for: .normal)
        cleanView.addTarget(self, action: #selector(crossTap), for: .touchUpInside)
        
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = MainFont.regular.withSize(14)
        textField.rightView = cleanView
        textField.rightViewMode = .always
    
        contentView.backgroundColor = .white.withAlphaComponent(0.15)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(textField)
        
        textField.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    
    // MARK: - Actions
    
    @objc private func crossTap() {
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
}

extension AlarmNameCell: Configurable {
    
    struct Model {
    
        let name: BehaviorSubject<String?>
    }
    
    func configure(with model: Model) {
        
        let disposeBag = DisposeBag()
    
        model.name
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)
        
        textField.rx.text
            .bind(to: model.name)
            .disposed(by: disposeBag)
        
        self.disposeBag = disposeBag
    }
}
