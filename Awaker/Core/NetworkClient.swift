//
//  NetworkClient.swift
//  Questionnaire
//
//  Created by Ilya Turin on 22.12.2021.
//

import Foundation

protocol NetworkClient {
    func parse<Model: Decodable>(rawData: Any, type: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void)
}

extension NetworkClient {
    
    func parse<Model: Decodable>(rawData: Any, type: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void) {
        
        globalQueue {
            
            // TODO: - Сделать выносную ошибку с комплишеном в меин
            
            guard (rawData as? NSNull) == nil else {
               // completion(.failure(.parseError))
                return
            }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: rawData)
                let decodedData = try JSONDecoder().decode(Model.self, from: json)
                
                mainQueue {
                    
                    completion(.success(decodedData))
                }
                
            } catch(let error) {
                print(error.localizedDescription)
               // completion(.failure(.parseError))
            }
        }
    }
    
}
