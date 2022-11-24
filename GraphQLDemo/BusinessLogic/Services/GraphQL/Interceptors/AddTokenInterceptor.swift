//
//  AddTokenInterceptor.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 22.11.2022.
//

import Foundation

import Apollo

class AddTokenInterceptor: ApolloInterceptor {
    
    enum AddTokenInterceptorError: Error {
        case noAccessToken
    }
    
    let credentialsService: CredentialsService
    
    init(credentialsService: CredentialsService) {
        self.credentialsService = credentialsService
    }
    
    func interceptAsync<Operation>(
        chain: Apollo.RequestChain,
        request: Apollo.HTTPRequest<Operation>,
        response: Apollo.HTTPResponse<Operation>?,
        completion: @escaping (Result<Apollo.GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : Apollo.GraphQLOperation {
            
            guard let accessToken = credentialsService.credentials?.accessToken else {
                chain.handleErrorAsync(
                    AddTokenInterceptorError.noAccessToken,
                    request: request,
                    response: response,
                    completion: completion
                )
                return
            }
            request.addHeader(name: "Authorization", value: "Bearer \(accessToken)")
            chain.proceedAsync(
                request: request,
                response: response,
                completion: completion
            )
    }
}
