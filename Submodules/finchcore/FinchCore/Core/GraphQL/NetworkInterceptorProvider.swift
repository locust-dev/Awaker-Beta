//
//  NetworkInterceptorProvider.swift
//
//  Created by Азиз on 27.08.2021.
//

import Apollo

final class NetworkInterceptorProvider: LegacyInterceptorProvider {
    
    // MARK: - Properties
    
    var headers: [String: String]?
    
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(headers: headers), at: 0)
        return interceptors
    }
}
