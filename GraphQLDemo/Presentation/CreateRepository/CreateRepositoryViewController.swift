//
//  CreateRepositoryViewController.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit

final class CreateRepositoryViewController: BaseViewController<CreateRepositoryViewModel> {
    // MARK: - Views
    private let contentView = CreateRepositoryView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        title = "Create repository"
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .titleChanged(let text):
                    viewModel.title = text
                    
                case .descriptionChanged(let text):
                    viewModel.description = text
                    
                case .didSelectScopeOption(let scope):
                    viewModel.scope = scope
                    
                case .doneTapped:
                    viewModel.onDoneTapped()
                }
            }
            .store(in: &cancellables)
    }
}
