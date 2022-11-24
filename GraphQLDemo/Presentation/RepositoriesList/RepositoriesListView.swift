//
//  RepositoriesListView.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

enum RepositoriesListViewAction {
    case didSelect(displayOption: RepositoryDisplayOption)
}

final class RepositoriesListView: BaseView {
    // MARK: - Subviews
    private let segmentedControl = UISegmentedControl()
    private let tableView = UITableView()
    
    private let displayOptions = RepositoryDisplayOption.allCases
    private var repositories: [RepositoryDomainModel] = []

    // MARK: - Action Publisher
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<RepositoriesListViewAction, Never>()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
}

// MARK: - Public methods
extension RepositoriesListView {
    func show(repositories: [RepositoryDomainModel]) {
        self.repositories = repositories
        tableView.reloadData()
    }
}

// MARK: - Private methods
private extension RepositoriesListView {
    func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }

    func bindActions() {
        segmentedControl.selectedSegmentIndexPublisher
            .compactMap { self.displayOptions[safe: $0] }
            .map { RepositoriesListViewAction.didSelect(displayOption: $0) }
            .sink { [unowned self] in actionSubject.send($0) }
            .store(in: &cancellables)
    }

    func setupUI() {
        backgroundColor = .white
        
        for (index, option) in displayOptions.enumerated() {
            segmentedControl.insertSegment(withTitle: option.title, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "RepositoryTableViewCell")
    }

    func setupLayout() {
        let stack = UIStackView()
        stack.setup()
        stack.addArranged(segmentedControl)
        stack.addArranged(tableView)
        addSubview(stack, withEdgeInsets: .init(top: 16, left: 16, bottom: 0, right: 16), safeArea: true)
    }
}

extension RepositoriesListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        if let repository = repositories[safe: indexPath.row] {
            cell.setup(with: repository)
        }
        return cell
    }
    
}

// MARK: - View constants
private enum Constant {
}

#if DEBUG
import SwiftUI
struct RepositoriesListPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(RepositoriesListView())
    }
}
#endif
