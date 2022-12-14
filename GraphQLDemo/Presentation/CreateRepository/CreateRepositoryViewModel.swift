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
        guard let title = title, !title.isEmpty else { return }
        repositoryService.createRepository(CreateRepositoryModel(title: title, description: description, scope: scope))
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorSubject.send(error)
                }
            } receiveValue: { [weak self] in
                self?.transitionSubject.send(.done)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private methods
private extension CreateRepositoryViewModel {
    
}
