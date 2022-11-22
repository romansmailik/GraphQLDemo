//
//  CreateRepositoryModuleBuilder.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

enum CreateRepositoryTransition: Transition {
    case done
}

final class CreateRepositoryModuleBuilder {
    class func build(container: AppContainer) -> Module<CreateRepositoryTransition, UIViewController> {
        let viewModel = CreateRepositoryViewModel(repositoryService: container.repositoryService)
        let viewController = CreateRepositoryViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
