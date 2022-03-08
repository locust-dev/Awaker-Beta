//
//  Dictionary+StringFromHTTPParameters.swift
//  FinchExtensions
//
//  Created by Vladimir Pchelyakov on 30.03.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

extension Dictionary {
    
    // MARK: - Public methods
    
    /// Конвертирует HTTP параметры в строку
    func stringFromHTTPParameters(allowPercentEncoding: Bool = false) -> String {
        
        let parameterArray = map { key, value -> String in
            if allowPercentEncoding {
                let encodingKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let encodingValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                return encodingKey + "=" + encodingValue
            } else {
                return "\(key)=\(value)"
            }
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}
