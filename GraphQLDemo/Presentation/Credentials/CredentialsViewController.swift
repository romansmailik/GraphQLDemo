//
//  CredentialsViewController.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit

final class CredentialsViewController: BaseViewController<CredentialsViewModel> {
    // MARK: - Views
    private let contentView = CredentialsView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .nicknameChanged(let nickname):
                    viewModel.nickname = nickname ?? ""
                case .tokenChanged(let token):
                    viewModel.accessToken = token ?? ""
                case .doneTapped:
                    viewModel.onDoneTapped()
                }
            }
            .store(in: &cancellables)
    }
}
