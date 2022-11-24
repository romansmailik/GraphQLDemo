//
//  NetworkInterceptorProvider.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 22.11.2022.
//

import Foundation
import Apollo

struct NetworkInterceptorProvider: InterceptorProvider {
    private let store: ApolloStore
    private let client: URLSessionClient
    private let credentialsService: CredentialsService
    
    init(store: ApolloStore,
         client: URLSessionClient,
         credentialsService: CredentialsService) {
        self.store = store
        self.client = client
        self.credentialsService = credentialsService
    }
    
    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
          MaxRetryInterceptor(),
          CacheReadInterceptor(store: self.store),
          AddTokenInterceptor(credentialsService: self.credentialsService),
          RequestLoggingInterceptor(),
          NetworkFetchInterceptor(client: self.client),
          ResponseLoggingInterceptor(),
          ResponseCodeInterceptor(),
          JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
          AutomaticPersistedQueryInterceptor(),
          CacheWriteInterceptor(store: self.store)
        ]
      }
}
