//
//  Alertable.swift
//  Questionnaire
//
//  Created by Ilya Turin on 13.12.2021.
//

import UIKit

protocol Alertable: AnyObject {
    
    func showAlert(title: String?,
                   message: String?,
                   buttonTitle: String?)
    
    @discardableResult
    func showAlert(_ alertController: UIAlertController?,
                   title: String?,
                   message: String?,
                   actions: [AlertAction]) -> UIAlertController
}


// MARK: - Default implementation
extension Alertable where Self: UIViewController {
    
    @discardableResult
    func showAlert(_ alertController: UIAlertController? = nil,
                   title: String? = nil,
                   message: String? = nil,
                   actions: [AlertAction]) -> UIAlertController {
        
        showAlert(
            alertController,
            title: title,
            message: message,
            actions: actions,
            style: .alert
        )
    }
    
    @discardableResult
    func showAlert(_ alertController: UIAlertController? = nil,
                   title: String? = nil,
                   message: String? = nil,
                   actions: [AlertAction],
                   style: UIAlertController.Style) -> UIAlertController {
        
        let alert: UIAlertController
        if let alertController = alertController {
            alertController.title = title
            alertController.message = message
            alert = alertController
        } else {
            alert = UIAlertController(title: title, message: message, preferredStyle: style)
        }
        
        let alertActions = actions.map { action in
            UIAlertAction(title: action.title, style: action.style) { _ in
                action.action?()
            }
        }
        
        alertActions.forEach { alert.addAction($0) }
        
        present(alert, animated: true)
        return alert
    }
    
    func showAlert(title: String?, message: String? = nil, buttonTitle: String? = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: buttonTitle, style: .cancel))
        present(alert, animated: true)
    }
    
}
