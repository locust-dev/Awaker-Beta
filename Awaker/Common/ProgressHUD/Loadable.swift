//
//  Loadable.swift
//  Awaker
//
//  Created by Ilya Turin on 10.12.2021.
//

import UIKit
import PureLayout

protocol Loadable {
    
    func showHUD()
    func showHUDOnWindow()
    func hideHUD()
}

extension Loadable where Self: UIViewController {
    
    // MARK: - Properties
    
    private var firstWindowScene: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    
    // MARK: - Public methods
    
    func showHUD() {
        showHUD(in: view)
    }
    
    func showHUDOnWindow() {
        
        guard let window = firstWindowScene else {
            return
        }
        
        showHUD(in: window)
    }
    
    func showHUD(in view: UIView,
                 size: ProgressHUDSize = .big,
                 bottomInset: CGFloat = 0,
                 needBackground: Bool = true) {
        
        mainQueue { [weak self] in
            guard self?.hud(for: view) == nil else {
                return
            }
            
            let containerView = ProgressHUDContainer()
            containerView.backgroundColor = .clear
            
            let hudView = ProgressHUD(size: size)
            containerView.addSubview(hudView)
            
            if needBackground {
                containerView.backgroundColor = .white
            } else {
                containerView.backgroundColor = .clear
            }
            
            hudView.autoSetDimensions(to: size.cgSize)
            hudView.autoCenterInSuperview()
            
            view.addSubview(containerView)
            containerView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
            containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: bottomInset)
        }
    }
    
    func hideHUD() {
        hideHUD(in: view)
    }
    
    func hideHUD(in view: UIView) {
        
        mainQueue { [weak self] in
            self?.hud(for: view)?.removeFromSuperview()
        }
    }
    
    
    // MARK: - Private methods
    
    private func hud(for view: UIView) -> UIView? {
        view.subviews.first { $0 is ProgressHUDContainer }
    }
    
}

extension UIViewController: Loadable { }
