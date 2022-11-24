//
//  RequestLoggingInterceptor.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 22.11.2022.
//

import Apollo

class RequestLoggingInterceptor: ApolloInterceptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            
            debugPrint("Outgoing request: \(request)")
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        }
}
