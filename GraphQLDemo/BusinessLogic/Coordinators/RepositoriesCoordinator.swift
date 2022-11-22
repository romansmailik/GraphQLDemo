//
//  RepositoriesCoordinator.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

final class RepositoriesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private let container: AppContainer
    private var cancellables = Set<AnyCancellable>()

    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        repositoriesList()
    }

    private func repositoriesList() {
        let module = RepositoriesListModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { [unowned self] transition in
                switch transition {
                case .createRepository:
                    createRepository()
                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }
    
    private func createRepository() {
        let module = CreateRepositoryModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { [unowned self] transition in
                switch transition {
                case .done:
                    pop()
                }
            }
            .store(in: &cancellables)
        push(module.viewController)
    }
}
