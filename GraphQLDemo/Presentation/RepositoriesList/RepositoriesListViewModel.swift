//
//  RepositoriesListViewModel.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Combine

final class RepositoriesListViewModel: BaseViewModel {
    // MARK: - Public properties
    @Published var repositories: [RepositoryDomainModel] = []
    
    // MARK: - Private properties
    private let credentialsService: CredentialsService
    private let repositoryService: RepositoriesService
    private var displayOption: RepositoryDisplayOption = .latest
    private var cache: [RepositoryDisplayOption: [RepositoryDomainModel]] = [:]
    
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<RepositoriesListTransition, Never>()
    
    init(credentialsService: CredentialsService, repositoryService: RepositoriesService) {
        self.credentialsService = credentialsService
        self.repositoryService = repositoryService
        super.init()
    }
    
    override func onViewWillAppear() {
        updateRepositories()
    }
    
    func showRepositories(for displayOption: RepositoryDisplayOption) {
        self.displayOption = displayOption
        updateRepositories()
    }
    
    func addNewRepository() {
        transitionSubject.send(.createRepository)
        updateRepositories()
    }
}

// MARK: - Private methods
private extension RepositoriesListViewModel {
    func updateRepositories() {
        switch displayOption {
        case .latest:   getLatestRepositories()
        case .top:      getTopRatedRepositories()
        }
    }
    
    func getLatestRepositories() {
        guard let username = credentialsService.credentials?.nickname else { return }
        repositories = cache[.latest] ?? []
        repositoryService.getLatestRepositories(username: username)
            .sink { [unowned self] completion in
                if case .failure(let error) = completion {
                    errorSubject.send(error)
                }
            } receiveValue: { [unowned self] repositories in
                self.repositories = repositories
                self.cache[.latest] = repositories
            }
            .store(in: &cancellables)
    }
    
    func getTopRatedRepositories() {
        guard let username = credentialsService.credentials?.nickname else { return }
        repositories = cache[.top] ?? []
        repositoryService.getTopRatedRepositories(username: username)
            .sink { [unowned self] completion in
                if case .failure(let error) = completion {
                    errorSubject.send(error)
                }
            } receiveValue: { [unowned self] repositories in
                self.repositories = repositories
                self.cache[.top] = repositories
            }
            .store(in: &cancellables)
    }
}
