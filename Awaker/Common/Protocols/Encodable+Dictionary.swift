//
//  Encodable+Dictionary.swift
//  Questionnaire
//
//  Created by Ilya Turin on 15.12.2021.
//

import Foundation

struct JSON {
    
    static let encoder = JSONEncoder()
}

extension Encodable {
    
    subscript(key: String) -> Any? {
        return asDictionary[key]
    }
    
    var asDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
