//
//  AppContainer.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Foundation
import Apollo

protocol AppContainer: AnyObject {
    var appConfiguration: AppConfiguration { get }
    var credentialsService: CredentialsService { get }
    var repositoryService: RepositoriesService { get }
}

final class AppContainerImpl: AppContainer {
    let appConfiguration: AppConfiguration
    let credentialsService: CredentialsService
    var repositoryService: RepositoriesService { RepositoriesServiceImpl(apolloClient: makeApolloClient()) }

    init() {
        let appConfiguration = AppConfigurationImpl()
        self.appConfiguration = appConfiguration
        
        let credentialsService = CredentialsServiceImpl()
        self.credentialsService = credentialsService
    }
    
    func makeApolloClient() -> ApolloClient {
        let url = URL(string: "https://api.github.com/graphql")!
        let configuration = URLSessionConfiguration.default
        
        let sessionClient = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let store = ApolloStore()
        
        let provider = NetworkInterceptorProvider(store: store, client: sessionClient, credentialsService: credentialsService)
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }
}
