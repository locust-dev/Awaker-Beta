//
//  Alertable.swift
//  Sportrecs
//
//  Created by VadimQw  on 14.08.2020.
//  Copyright © 2020 Finch. All rights reserved.
//

import UIKit

protocol Alertable {
    
    func showAlert(title: String,
                   message: String,
                   style: UIAlertController.Style,
                   actions: [UIAlertAction],
                   preferredAction: UIAlertAction?)
}


// MARK: - For UIViewController
extension Alertable where Self: UIViewController {
    
    // MARK: - Public methods
    
    func showAlert(title: String,
                   message: String,
                   style: UIAlertController.Style,
                   actions: [UIAlertAction],
                   preferredAction: UIAlertAction?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        
        if let preferredAction = preferredAction {
            alert.addAction(preferredAction)
            alert.preferredAction = preferredAction
        }
        
        present(alert, animated: true)
    }
    
}
