//
//  CreateRepositoryViewModel.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Combine

final class CreateRepositoryViewModel: BaseViewModel {
    // MARK: - Public properties
    @Published var title: String?
    @Published var description: String?
    @Published var scope: RepositoryScopeOption = .private
    
    // MARK: - Private properties
    private let repositoryService: RepositoriesService
    
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<CreateRepositoryTransition, Never>()
    
    init(repositoryService: RepositoriesService) {
        self.repositoryService = repositoryService
        super.init()
    }
    
    func onDoneTapped() {
        transitionSubject.send(.done)
    }
}

// MARK: - Private methods
private extension CreateRepositoryViewModel {
    
}
