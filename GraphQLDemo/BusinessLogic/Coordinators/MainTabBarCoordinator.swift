//
//  MainTabBarCoordinator.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import UIKit
import Combine

final class MainTabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: AppContainer

    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        setupRepositoriesCoordinator()
        setupSettingsCoordinator()

        let controllers = childCoordinators.compactMap { $0.navigationController }
        let module = MainTabBarModuleBuilder.build(viewControllers: controllers)
        setRoot(module.viewController)
    }
    
    private func setupRepositoriesCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(title: Localization.repositories,
                                         image: UIImage(systemName: "folder"),
                                         selectedImage: UIImage(systemName: "folder.fill"))
        let coordinator = RepositoriesCoordinator(navigationController: navController, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func setupSettingsCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(title: Localization.settings,
                                         image: UIImage(systemName: "gearshape"),
                                         selectedImage: UIImage(systemName: "gearshape.fill"))
        let coordinator = SettingsCoordinator(navigationController: navController, container: container)
        childCoordinators.append(coordinator)
        coordinator.didFinishPublisher
            .sink { [unowned self] in
                childCoordinators.forEach { removeChild(coordinator: $0) }
                didFinishSubject.send()
            }
            .store(in: &cancellables)
        coordinator.start()
    }
}
