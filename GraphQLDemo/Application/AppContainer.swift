//
//  AppContainer.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Foundation
import CombineNetworking

protocol AppContainer: AnyObject {
    var appConfiguration: AppConfiguration { get }
    var credentialsService: CredentialsService { get }
    var repositoryService: RepositoriesService { get }
}

final class AppContainerImpl: AppContainer {
    let appConfiguration: AppConfiguration
    let credentialsService: CredentialsService
    var repositoryService: RepositoriesService {
        RepositoriesServiceImpl()
    }

    init() {
        let appConfiguration = AppConfigurationImpl()
        self.appConfiguration = appConfiguration
        
        let credentialsService = CredentialsServiceImpl()
        self.credentialsService = credentialsService
    }
}
