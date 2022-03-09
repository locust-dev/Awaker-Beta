//
//  ErrorPlaceholder.swift
//  MobileShip
//
//  Created by Ilya Turin on 16.12.2021.
//

import UIKit
import PureLayout

protocol ErrorPlaceholderDelegate: AnyObject {
    func didTapErrorPlaceholderOkButton()
}

final class ErrorPlaceholder: NLView {
    
    // MARK: - Properties
    
    weak var delegate: ErrorPlaceholderDelegate?
    
    private let error: ErrorModel
    private let titleLabel = UILabel()
    private let okButton = UIButton()
    
    
    // MARK: - Init
    
    init(error: ErrorModel) {
        self.error = error
        super.init(frame: .zero)
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.text = error.description
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        okButton.addTarget(self, action: #selector(okTap), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(okButton)
        okButton.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), excludingEdge: .top)
        okButton.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        okButton.autoSetDimension(.height, toSize: 50)
        titleLabel.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
    }
    
    
    // MARK: - Actions
    
    @objc private func okTap() {
        delegate?.didTapErrorPlaceholderOkButton()
    }
    
}
