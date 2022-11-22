//
//  CreateRepositoryView.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

enum CreateRepositoryViewAction {
    case titleChanged(String?)
    case descriptionChanged(String?)
    case didSelectScopeOption(RepositoryScopeOption)
    case doneTapped
}

enum RepositoryScopeOption: CaseIterable {
    case `private`
    case `public`
    
    var title: String {
        switch self {
        case .private:
            return "Private"
        case .public:
            return "Public"
        }
    }
}

final class CreateRepositoryView: BaseView {
    // MARK: - Subviews
    private let titleTextField = UITextField()
    private let desciptionTextField = UITextField()
    private let scopeSegmentedControl = UISegmentedControl()
    private let doneButton = UIButton()

    // MARK: - Action Publisher
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<CreateRepositoryViewAction, Never>()
    
    private let scopeOptions = RepositoryScopeOption.allCases

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
extension CreateRepositoryView {
}

// MARK: - Private methods
private extension CreateRepositoryView {
    func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }

    func bindActions() {
        titleTextField.textPublisher
            .map { CreateRepositoryViewAction.titleChanged($0) }
            .sink { [unowned self] in actionSubject.send($0) }
            .store(in: &cancellables)
        
        desciptionTextField.textPublisher
            .map { CreateRepositoryViewAction.descriptionChanged($0) }
            .sink { [unowned self] in actionSubject.send($0) }
            .store(in: &cancellables)
        
        scopeSegmentedControl.selectedSegmentIndexPublisher
            .compactMap { self.scopeOptions[safe: $0] }
            .map { CreateRepositoryViewAction.didSelectScopeOption($0) }
            .sink { [unowned self] in actionSubject.send($0) }
            .store(in: &cancellables)
        
        doneButton.tapPublisher
            .map { CreateRepositoryViewAction.doneTapped }
            .sink { [unowned self] in actionSubject.send($0) }
            .store(in: &cancellables)
    }

    func setupUI() {
        backgroundColor = .white
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .roundedRect
        
        desciptionTextField.placeholder = "Description"
        desciptionTextField.borderStyle = .roundedRect
        
        for (index, option) in scopeOptions.enumerated() {
            scopeSegmentedControl.insertSegment(withTitle: option.title, at: index, animated: false)
        }
        scopeSegmentedControl.selectedSegmentIndex = 0
        
        doneButton.backgroundColor = .systemBlue
        doneButton.rounded(12)
        doneButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        doneButton.setTitle("Create", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
    }

    func setupLayout() {
        let stack = UIStackView()
        stack.setup(spacing: 8)
        stack.addArranged(titleTextField, size: 42)
        stack.addArranged(desciptionTextField, size: 42)
        stack.addArranged(scopeSegmentedControl)
        stack.addSpacer()
        stack.addArranged(doneButton, size: 50)
        
        addSubview(stack, withEdgeInsets: .init(top: 8, left: 16, bottom: 8, right: 16), safeArea: true, bottomToKeyboard: true)
    }
}

// MARK: - View constants
private enum Constant {
}

#if DEBUG
import SwiftUI
struct CreateRepositoryPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(CreateRepositoryView())
    }
}
#endif
