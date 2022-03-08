//
//  InternetConnectionReachabilityHandler.swift
//  FinchCore
//
//  Created by VadimQw  on 13.08.2020.
//  Copyright © 2020 FINCH. All rights reserved.
//

import Foundation

protocol InternetConnectionReachabilityHandlerDelegate: AnyObject {
    func internetConnectionReachabilityStatusChanged(_ status: InternetConnectionReachability.Status)
}

final class InternetConnectionReachabilityHandler {
    
    // MARK: - Properties
    
    private weak var delegate: InternetConnectionReachabilityHandlerDelegate?
    
    
    // MARK: - Init
    
    init(delegate: InternetConnectionReachabilityHandlerDelegate) {
        
        self.delegate = delegate
        if let status = InternetConnectionReachabilityCenter.shared.internetConnectionReachabilityStatus {
            delegate.internetConnectionReachabilityStatusChanged(status)
        }
        subscribeToNotifications()
    }
    
    
    // MARK: - Private methods
    
    private func subscribeToNotifications() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(internetConnectionReachabilityStatusChanged(notification:)),
            name: .internetConnectionReachabilityStatusChanged,
            object: nil
        )
    }
    
    
    // MARK: - Actions
    
    @objc private func internetConnectionReachabilityStatusChanged(notification: Notification) {
        
        if let status = notification.object as? InternetConnectionReachability.Status {
            delegate?.internetConnectionReachabilityStatusChanged(status)
        }
    }
    
}
