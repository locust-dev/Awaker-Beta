//
//  ErrorPresentable.swift
//  Questionnaire
//
//  Created by Ilya Turin on 16.12.2021.
//

import UIKit

protocol ErrorPresentable: ErrorPlaceholderDelegate {
    
    func showErrorPlaceholder(_ error: ErrorModel)
}


// MARK: - Default implementation
extension ErrorPresentable where Self: UIViewController {
    
    func showErrorPlaceholder(_ error: ErrorModel) {
        
        let errorPlaceholeder = ErrorPlaceholder(error: error)
        errorPlaceholeder.delegate = self
    
        view.addSubview(errorPlaceholeder)
        errorPlaceholeder.autoPinEdgesToSuperviewEdges()
    }
    
    func didTapErrorPlaceholderOkButton() {
        removeErrorFromSuperview()
    }
    
    
    // MARK: - Private methods
    
    private func removeErrorFromSuperview() {
        
        view.subviews.forEach { view in
            if let errorPlaceholeder = view as? ErrorPlaceholder {
                errorPlaceholeder.delegate = nil
                errorPlaceholeder.removeFromSuperview()
            }
        }
    }
    
}
