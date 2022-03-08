//
//  UIApplication+AppVersion.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 30.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

extension UIApplication {
    
    // MARK: - Public methods
    
    /// Возвращает версию приложения
    static func appVersion() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        return version ?? ""
    }
    
    /// Возвращает build номер
    static func appBuild() -> String {
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        return build ?? ""
    }
    
    /// Возвращает версию приложения и build номер - "1.0.0 (3)"
    static func fullApplicationVersion() -> String {
        "\(appVersion()) (\(appBuild()))"
    }
    
}
