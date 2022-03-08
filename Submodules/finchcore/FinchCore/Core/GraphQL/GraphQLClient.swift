//
//  GraphQLClient.swift
//
//  Created by Азиз on 27.08.2021.
//  Copyright © 2021 Finch. All rights reserved.
//

import Apollo

protocol GraphQLClientInput: AnyObject {
    
    var headers: [String: String]? { get set }
    
    func fetch<Model: Decodable, Request: GraphQLQuery>(query: Request,
                                                        completion: @escaping ((Result<Model, GraphQLError>) -> Void))
    
    func fetchCollectWordInfo<Model: Decodable, Request: GraphQLQuery>(query: Request,
                                                                       headers: [String: String]?,
                                                                       completion: @escaping ((Result<Model, GraphQLError>) -> Void))
    
    func mutate<Model: Decodable, Request: GraphQLMutation>(mutation: Request,
                                                            completion: @escaping ((Result<Model, GraphQLError>) -> Void))
}

final class GraphQLClient {
    
    // MARK: - Properties
    
    var headers: [String: String]?
    
    private let baseGraphQLPath: URL
    private let store = ApolloStore()
    
    private var apolloClient: ApolloClient {
        
        let configuration = URLSessionConfiguration.default
        let urlSessionClient = URLSessionClient(sessionConfiguration: configuration)
        let interceptorProvider = NetworkInterceptorProvider(client: urlSessionClient,
                                                             shouldInvalidateClientOnDeinit: false,
                                                             store: store)
        
        interceptorProvider.headers = headers
        let networkTransport = RequestChainNetworkTransport(interceptorProvider: interceptorProvider,
                                                            endpointURL: baseGraphQLPath)
        
        return ApolloClient(networkTransport: networkTransport, store: store)
    }
    
    
    // MARK: - Init
    
    required init(baseGraphQLPath: URL, headers: [String: String]? = nil) {
        self.headers = headers
        self.baseGraphQLPath = baseGraphQLPath
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(removeHeaders),
            name: .didLogout,
            object: nil
        )
    }
    
    
    // MARK: - Private methods
    
    @objc private func removeHeaders() {
        self.headers = nil
    }
    
    private func parse<Model: Decodable>(selectionSet: GraphQLSelectionSet,
                                         completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        do {
            let data = try JSONSerialization.data(withJSONObject: selectionSet.jsonObject.jsonValue,
                                                  options: [])
            let model = try JSONDecoder().decode(Model.self, from: data)
            completion(.success(model))
        } catch let error {
            completion(.failure(.couldNotParse(error)))
        }
    }
}


// MARK: - GraphQLClientInput
extension GraphQLClient: GraphQLClientInput {

    func fetchCollectWordInfo<Model: Decodable, Request: GraphQLQuery>(query: Request,
                                                                       headers: [String: String]?,
                                                                       completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        self.headers = headers
        apolloClient.fetch(query: query,
                           cachePolicy: .fetchIgnoringCacheCompletely,
                           contextIdentifier: nil,
                           queue: .main) { [weak self] result in
            switch result {
            
            case let .success(response):
                if let errors = response.errors {
                    completion(.failure(.backendError(errors)))
                    
                } else if let data = response.data {
                    self?.parse(selectionSet: data, completion: completion)
                    
                } else {
                    completion(.failure(.unknownError))
                }
                
            case let .failure(error):
                NSLog(error.localizedDescription)
                completion(.failure(.couldNotParse(error)))
            }
        }
    }
    
    
    func fetch<Model: Decodable, Request: GraphQLQuery>(query: Request,
                                                        completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        apolloClient.fetch(query: query,
                           cachePolicy: .fetchIgnoringCacheCompletely,
                           contextIdentifier: nil,
                           queue: .main) { [weak self] result in
            switch result {
            
            case let .success(response):
                if let errors = response.errors {
                    completion(.failure(.backendError(errors)))
                    
                } else if let data = response.data {
                    self?.parse(selectionSet: data, completion: completion)
                    
                } else {
                    completion(.failure(.unknownError))
                }
                
            case let .failure(error):
                NSLog(error.localizedDescription)
                completion(.failure(.couldNotParse(error)))
            }
        }
    }
    
    func mutate<Model: Decodable, Request: GraphQLMutation>(mutation: Request,
                                                            completion: @escaping ((Result<Model, GraphQLError>) -> Void)) {
        
        apolloClient.perform(mutation: mutation) { [weak self] result in
            switch result {
            
            case let .success(response):
                if let errors = response.errors {
                    completion(.failure(.backendError(errors)))
                    
                } else if let data = response.data {
                    self?.parse(selectionSet: data, completion: completion)
                    
                } else {
                    completion(.failure(.unknownError))
                }
                
            case let .failure(error):
                NSLog(error.localizedDescription)
                completion(.failure(.couldNotParse(error)))
            }
        }
    }
}
