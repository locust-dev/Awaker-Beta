//
//  InternetConnectionReachabilityCenter.swift
//  FinchCore
//
//  Created by VadimQw  on 13.08.2020.
//  Copyright © 2020 FINCH. All rights reserved.
//

final class InternetConnectionReachabilityCenter {
    
    // MARK: - Locals
    
    private enum Locals {
        static let defaultHostname = "www.google.com"
    }
    
    
    // MARK: - Properties
    
    public static let shared = InternetConnectionReachabilityCenter()
    
    var internetConnectionReachabilityStatus: InternetConnectionReachability.Status? {
        reachability?.status
    }
    
    private var reachability: InternetConnectionReachability?
    
    private var isRunningOnDevice: Bool = {
        
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }()
    
    
    // MARK: - Init
    
    private init() {  }
    
    
    // MARK: - Public methods
    
    func startTrackingInternetConnectionReachability() {
        
        guard isRunningOnDevice else {
            return
        }
        
        do {
            try reachability = InternetConnectionReachability(hostname: Locals.defaultHostname)
        } catch {
            if let error = error as? InternetConnectionReachability.Errors {
                print(error.description)
            } else {
                print(error)
            }
        }
    }
    
}
