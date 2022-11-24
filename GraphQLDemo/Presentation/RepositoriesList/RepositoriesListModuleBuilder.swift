//
//  RepositoriesListModuleBuilder.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

enum RepositoriesListTransition: Transition {
    case createRepository
}

final class RepositoriesListModuleBuilder {
    class func build(container: AppContainer) -> Module<RepositoriesListTransition, UIViewController> {
        let viewModel = RepositoriesListViewModel(
            credentialsService: container.credentialsService,
            repositoryService: container.repositoryService
        )
        let viewController = RepositoriesListViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
