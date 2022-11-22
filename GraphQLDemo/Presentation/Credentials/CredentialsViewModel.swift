//
//  CredentialsViewModel.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Combine

final class CredentialsViewModel: BaseViewModel {
    // MARK: - Public properties
    @Published var nickname: String = ""
    @Published var accessToken: String = ""
    
    // MARK: - Private properties
    private let credentialsService: CredentialsService
    
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<CredentialsTransition, Never>()
    
    init(credentialsService: CredentialsService) {
        self.credentialsService = credentialsService
        super.init()
    }
    
}

// MARK: - Public methods
extension CredentialsViewModel {
    func onDoneTapped() {
        guard !nickname.isEmpty, !accessToken.isEmpty else {
            return
        }
        let credentials = Credentials(nickname: nickname, accessToken: accessToken)
        credentialsService.save(credentials)
        transitionSubject.send(.authorized)
    }
}

// MARK: - Private methods
private extension CredentialsViewModel {
    
}
