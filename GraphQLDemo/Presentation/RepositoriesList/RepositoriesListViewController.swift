//
//  RepositoriesListViewController.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit

final class RepositoriesListViewController: BaseViewController<RepositoriesListViewModel> {
    // MARK: - Views
    private let contentView = RepositoriesListView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        title = Localization.repositories
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .didSelect(let displayOption):
                    viewModel.showRepositories(for: displayOption)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$repositories
            .sink { [unowned self] in contentView.show(repositories: $0) }
            .store(in: &cancellables)
    }
    
    @objc private func addButtonTapped() {
        viewModel.addNewRepository()
    }
}
