//
//  CredentialsModuleBuilder.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

enum CredentialsTransition: Transition {
    case authorized
}

final class CredentialsModuleBuilder {
    class func build(container: AppContainer) -> Module<CredentialsTransition, UIViewController> {
        let viewModel = CredentialsViewModel(credentialsService: container.credentialsService)
        let viewController = CredentialsViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
