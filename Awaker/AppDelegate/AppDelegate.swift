//
//  AppDelegate.swift
//  Awaker
//
//  Created by MobileShip on 05.03.2022.
//

import UIKit
//import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
}
