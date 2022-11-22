//
//  RepositoriesListViewModel.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Combine

final class RepositoriesListViewModel: BaseViewModel {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let repositoryService: RepositoriesService
    
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<RepositoriesListTransition, Never>()
    
    init(repositoryService: RepositoriesService) {
        self.repositoryService = repositoryService
        super.init()
    }
    
    func showRepositories(for displayOption: RepositoryDisplayOption) {
        
    }
    
    func addNewRepository() {
        transitionSubject.send(.createRepository)
    }
}

// MARK: - Private methods
private extension RepositoriesListViewModel {
    
}
