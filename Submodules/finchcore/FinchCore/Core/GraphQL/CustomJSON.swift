//
//  CustomJSON.swift
//
//  Created by Aleksandr Konakov on 08.05.2021.
//

import Apollo

// Добавлено для поддержки JSON-полей в GraphQL
// Без этих плясок оно падает где-то в недрах Apollo

public enum CustomJSON {
    case dictionary([String: Any])
    case array([Any])
}


// MARK: - JSONDecodable
extension CustomJSON: JSONDecodable {
    
    public init(jsonValue value: JSONValue) throws {
        
        if let dict = value as? [String: Any] {
            self = .dictionary(dict)
        } else if let array = value as? [Any] {
            self = .array(array)
        } else {
            throw JSONDecodingError.couldNotConvert(value: value, to: CustomJSON.self)
        }
    }
    
}


// MARK: - JSONEncodable
extension CustomJSON: JSONEncodable {
    
    public var jsonValue: JSONValue {
        
        switch self {
        
        case let .dictionary(dictionary):
           return dictionary.jsonValue
            
        case  let .array(array):
           return array.jsonValue
        }
    }
    
}
