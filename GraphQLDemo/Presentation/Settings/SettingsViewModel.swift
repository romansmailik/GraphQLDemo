//
//  SettingsViewModel.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Combine

final class SettingsViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<SettingsTransition, Never>()
    
    private let credentialsService: CredentialsService
    
    init(credentialsService: CredentialsService) {
        self.credentialsService = credentialsService
        super.init()
    }
    
    func logout() {
        credentialsService.clear()
        transitionSubject.send(.logout)
    }
}
