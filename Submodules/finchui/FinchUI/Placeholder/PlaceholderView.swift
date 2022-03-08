//
//  PlaceholderView.swift
//  TestErrrorView
//
//  Created by Anton on 14.08.2020.
//  Copyright © 2020 Potapov Anton. All rights reserved.
//

import UIKit

protocol PlaceholderDelegate: AnyObject {
    func didTapRefreshButton()
}

final class PlaceholderView: NLView {
    
    // MARK: - Types
    
    enum PlaceholderType {
        case image
        case error(title: String, buttonTitle: String = Locals.errorPlaceholderButtonTitle)
    }
    
    struct AppearanceModel {
        let itemsColor: UIColor
        let backgroundColor: UIColor
        let font: UIFont
    }
    
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let imageName = "noImagePlaceholder"
        static let reloadImageName = "reloadPlaceholder"
        static let errorPlaceholderButtonTitle = "Повторить"
        
        @available(iOS 13.0, *)
        enum iOS13AndUpColors { // swiftlint:disable:this type_name
            static let defaultItemsColorIOS13Available = UIColor.label.withAlphaComponent(0.5)
            static let defaultBackgroundColorIOS13Available: UIColor = .systemBackground
        }
        
        enum iOS12AndLessColors { // swiftlint:disable:this type_name
            static let defaultItemsColor = UIColor(red: 0.549, green: 0.549, blue: 0.549, alpha: 1)
            static let defaultBackgroundColor: UIColor = .white
        }
        
        enum Button {
        
            static let contentEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
            static let padding = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
            static let height: CGFloat = 32
            static let borderWidth: CGFloat = 1
            
        }
        
        enum Title {
            
            static let offset: CGFloat = 16
            
        }
        
    }
    
    
    // MARK: - Properties
    
    weak var delegate: PlaceholderDelegate?
    
    private var type: PlaceholderType = .image
    private var appearanceModel: AppearanceModel?
    
    private let actionButton = UIButton()
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
    
    private init(type: PlaceholderType) {
        super.init(frame: .zero)
        
        self.type = type
        translatesAutoresizingMaskIntoConstraints = false
        drawSelf()
    }
    
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        drawPresentation()
        setupAppearance()
    }
    
    
    // MARK: - Drawning
    
    private func drawSelf() {
        
        switch type {
        
        case .error(title: let title, buttonTitle: let buttonTitle):
            configureErrorView(withTitle: title, buttonTitle: buttonTitle)
            
        case .image:
            configureImageView()
        }
    }
    
    
    // MARK: - Public methods
    
    @discardableResult
    static func showPlaceholder(withType type: PlaceholderType,
                                delegate: PlaceholderDelegate? = nil,
                                on view: UIView) -> PlaceholderView {
        
        let placeholder = PlaceholderView(type: type)
        placeholder.delegate = delegate
        view.addSubview(placeholder)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: placeholder.topAnchor),
            view.rightAnchor.constraint(equalTo: placeholder.rightAnchor),
            view.leftAnchor.constraint(equalTo: placeholder.leftAnchor),
            view.bottomAnchor.constraint(equalTo: placeholder.bottomAnchor)
        ])
        
        return placeholder
    }
    
    func applyAppearance(_ appearanceModel: AppearanceModel) {
        self.appearanceModel = appearanceModel
        setupAppearance()
    }
    
    
    // MARK: - Private methods
    
    private func setupAppearance() {
        
        guard let appearanceModel = appearanceModel else {
            return
        }
        
        backgroundColor = appearanceModel.backgroundColor
        
        switch type {
        
        case .error:
            titleLabel.textColor = appearanceModel.itemsColor
            titleLabel.font = appearanceModel.font
            actionButton.titleLabel?.font = appearanceModel.font
            actionButton.setTitleColor(appearanceModel.itemsColor, for: .normal)
            actionButton.layer.borderColor = appearanceModel.itemsColor.cgColor
            
        case .image:
            break
        }
    }
    
    private func configureErrorView(withTitle title: String, buttonTitle: String) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let itemsColor: UIColor
        if #available(iOS 13.0, *) {
            itemsColor = Locals.iOS13AndUpColors.defaultItemsColorIOS13Available
            backgroundColor = Locals.iOS13AndUpColors.defaultBackgroundColorIOS13Available
        } else {
            itemsColor = Locals.iOS12AndLessColors.defaultItemsColor
            backgroundColor = Locals.iOS12AndLessColors.defaultBackgroundColor
        }
        
        addSubview(containerView)
        
        titleLabel.text = title
        titleLabel.textColor = itemsColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitleColor(itemsColor, for: .normal)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.contentEdgeInsets = Locals.Button.contentEdgeInsets
        actionButton.layer.cornerRadius = Locals.Button.height / 2
        actionButton.layer.borderWidth = Locals.Button.borderWidth
        actionButton.layer.borderColor = itemsColor.cgColor
        actionButton.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)
        containerView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Locals.Title.offset),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Locals.Title.offset),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Locals.Button.padding.top),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor, constant: Locals.Button.padding.left),
            actionButton.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -Locals.Button.padding.right),
            actionButton.heightAnchor.constraint(equalToConstant: Locals.Button.height),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
           
        ])
    }
    
    private func configureImageView() {
        
        guard let image = UIImage(named: Locals.imageName) else {
            return
        }
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func drawPresentation() {
        
        switch type {
        
        case .error(let title, let buttonTitle):
            subviews.forEach({ $0.removeFromSuperview() })
            actionButton.setImage(nil, for: .normal)
            configureErrorView(withTitle: title, buttonTitle: buttonTitle)
            
        default:
            break
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func reloadAction() {
        delegate?.didTapRefreshButton()
        removeFromSuperview()
    }
    
}
