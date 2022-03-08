//
//  CustomInterceptor.swift
//
//  Created by Азиз on 29.08.2021.
//  Copyright © 2021 Finch. All rights reserved.
//

import Apollo

final class CustomInterceptor {
    
    // MARK: - Properties
    
    private let headers: [String: String]?
    
    
    // MARK: - Init
    
    required init(headers: [String: String]? = nil) {
        self.headers = headers
    }
}


// MARK: - ApolloInterceptor
extension CustomInterceptor: ApolloInterceptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        if let headers = headers {
            headers.forEach {
                request.addHeader(name: $0.key, value: $0.value)
            }
        }
        
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
    
}
