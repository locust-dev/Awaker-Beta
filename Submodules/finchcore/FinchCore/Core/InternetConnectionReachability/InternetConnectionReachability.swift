//
//  InternetConnectionReachability.swift
//  FinchCore
//
//  Created by VadimQw  on 13.08.2020.
//  Copyright © 2020 FINCH. All rights reserved.
//

import Foundation
import SystemConfiguration

final class InternetConnectionReachability {
    
    // MARK: - Locals
    
    private enum Locals {
        static let errorPrefix = "InternetConnectionReachability :: "
        static let reachabilityQueueLabel = "InternetConnectionReachabilityQueue"
    }
    
    
    // MARK: - Properties
    
    var status: Status {
        !isConnectedToNetwork ? .unreachable : isReachableViaWiFi ? .wifi : .wwan
    }
    
    private var reachability: SCNetworkReachability?
    private var reachabilityFlags = SCNetworkReachabilityFlags()
    
    private let reachabilityQueue = DispatchQueue(label: Locals.reachabilityQueueLabel)
    
    private var isReachable: Bool {
        reachabilityFlags.contains(.reachable)
    }
    
    private var isWWAN: Bool {
        reachabilityFlags.contains(.isWWAN)
    }
    
    private var isReachableViaWiFi: Bool {
        isReachable && !isWWAN
    }
    
    private var isConnectionRequiredAndTransientConnection: Bool {
        
        let flags: SCNetworkReachabilityFlags = [.connectionRequired, .transientConnection]
        let intersection = reachabilityFlags.intersection(flags)
        return intersection == flags
    }
    
    private var isConnectedToNetwork: Bool {
        isReachable && !isConnectionRequiredAndTransientConnection
    }
    
    
    // MARK: - Init
    
    init(hostname: String) throws {
        
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, hostname) else {
            throw Errors.failedCreateWithHostname(hostname)
        }
        
        self.reachability = reachability
        try startInternetConnection()
    }
    
    
    // MARK: - Deinit
    
    deinit {
        stopInternetConnection()
    }
    
    
    // MARK: - Public methods
    
    func flagsChanged() {
        
        guard let flags = fetchFlags(), flags != reachabilityFlags else {
            return
        }
        
        reachabilityFlags = flags
        NotificationCenter.default.post(
            name: .internetConnectionReachabilityStatusChanged,
            object: status
        )
    }
    
    
    // MARK: - Private methods
    
    private func startInternetConnection() throws {
        
        guard let reachability = reachability else {
            return
        }
        
        var context = SCNetworkReachabilityContext(
            version: 0,
            info: nil,
            retain: nil,
            release: nil,
            copyDescription: nil
        )
        
        context.info = Unmanaged<InternetConnectionReachability>.passUnretained(self).toOpaque()
        guard SCNetworkReachabilitySetCallback(reachability, networkReachabilityCallback, &context) else {
            stopInternetConnection()
            throw Errors.failedSetCallback
        }
        
        guard SCNetworkReachabilitySetDispatchQueue(reachability, reachabilityQueue) else {
            stopInternetConnection()
            throw Errors.failedSetReachabilityQueue
        }
        
        reachabilityQueue.async { [weak self] in
            self?.flagsChanged()
        }
    }
    
    private func stopInternetConnection() {
        
        guard let reachability = reachability else {
            return
        }
        
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        self.reachability = nil
    }
    
    private func fetchFlags() -> SCNetworkReachabilityFlags? {
        
        guard let reachability = reachability else {
            return nil
        }
        
        var flags = SCNetworkReachabilityFlags()
        return withUnsafeMutablePointer(to: &flags) {
            SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0))
        } ? flags : nil
    }
    
}


// MARK: - Errors
extension InternetConnectionReachability {
    
    enum Errors: Error {
        
        case failedSetCallback
        case failedSetReachabilityQueue
        case failedCreateWithHostname(_ hostname: String)
        
        
        // MARK: - Properties
        
        var description: String {
            
            var description = Locals.errorPrefix
            
            switch self {
            
            case .failedSetCallback:
                description += "Failed set callback!"
                
            case .failedSetReachabilityQueue:
                description += "Failed set reachability queue!"
                
            case .failedCreateWithHostname(let hostname):
                description += "Failed create reachability object with hostname: \(hostname)"
            }
            
            return description
        }
        
    }
    
}


// MARK: - Statuses
extension InternetConnectionReachability {
    
    enum Status {
        
        case wwan
        case wifi
        case unreachable
        
    }
    
}


// MARK: - NetworkReachabilityCallback
private func networkReachabilityCallback(reachability: SCNetworkReachability,
                                         flags: SCNetworkReachabilityFlags,
                                         info: UnsafeMutableRawPointer?) {
    
    guard let info = info else {
        return
    }
    
    mainQueue {
        Unmanaged<InternetConnectionReachability>.fromOpaque(info).takeUnretainedValue().flagsChanged()
    }
}


// MARK: - Notification Names
extension Notification.Name {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let statusChangedNotificationName = "internetConnectionReachabilityStatusChanged"
    }
    
    
    // MARK: - Public Properties
    
    static let internetConnectionReachabilityStatusChanged = Notification.Name(Locals.statusChangedNotificationName)
    
}
