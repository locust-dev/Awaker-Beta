//
//  String+Dictionary.swift
//  avansbox
//
//  Created by Konstantin Poznyak on 24.06.2021.
//

import Foundation

extension String {
    
    // MARK: - Properties
    
    var dictionary: [String: Any]? {
        
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
