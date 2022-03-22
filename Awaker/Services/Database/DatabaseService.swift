//
//  DatabaseService.swift
//  Awaker
//
//  Created by Ilya Turin on 11.12.2021.
//

import FirebaseDatabase

protocol DatabaseServiceInput: NetworkClient {
    func getData<Model: Decodable>(_ key: DatabasePath, modelType: Model.Type, completion: @escaping (Result<Model, ErrorModel>) -> Void)
}

final class DatabaseService {
    
    // MARK: - Types
    
    private enum DatabaseReference {
        
         static let realtime = Bundle.main.object(forInfoDictionaryKey: "DatabaseReference")
    }
    
    
    // MARK: - Properties
    
    private let databaseReference = Database.database(url: DatabaseReference.realtime as! String).reference()

}


// MARK: - FirebaseDatabaseServiceProtocol
extension DatabaseService: DatabaseServiceInput {
    
    func getData<Model: Decodable>(_ key: DatabasePath,
                                   modelType: Model.Type,
                                   completion: @escaping (Result<Model, ErrorModel>) -> Void) {
        
        globalQueue {
            
            self.databaseReference.child(key.stringPath).getData { [weak self] error, data in

                guard let dataValue = data.value, error == nil else {
                   // completion(.failure(.serverError))
                    return
                }

                self?.parse(rawData: dataValue, type: modelType, completion: completion)
            }
        }
        
    }
    
}
