//
//  CredentialsView.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit
import Combine

enum CredentialsViewAction {
    case nicknameChanged(nickname: String?)
    case tokenChanged(token: String?)
    case doneTapped
}

final class CredentialsView: BaseView {
    // MARK: - Subviews
    private let logoImageView = UIImageView()
    private let nicknameTextField = UITextField()
    private let tokenTextField = UITextField()
    private let doneButton = UIButton()

    // MARK: - Action Publisher
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<CredentialsViewAction, Never>()

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
extension CredentialsView {
}

// MARK: - Private methods
private extension CredentialsView {
    func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }

    func bindActions() {
        nicknameTextField.textPublisher
            .sink { [unowned self] in actionSubject.send(.nicknameChanged(nickname: $0)) }
            .store(in: &cancellables)
        
        tokenTextField.textPublisher
            .sink { [unowned self] in actionSubject.send(.tokenChanged(token: $0)) }
            .store(in: &cancellables)
        
        doneButton.tapPublisher
            .sink { [unowned self] in actionSubject.send(.doneTapped) }
            .store(in: &cancellables)
    }

    func setupUI() {
        backgroundColor = .white
        
        logoImageView.image = Assets.github.image
        logoImageView.contentMode = .scaleAspectFit
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.placeholder = "GitHub nickname"
        tokenTextField.borderStyle = .roundedRect
        tokenTextField.placeholder = "GitHub access token"
        doneButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.rounded(Constant.doneButtonCornerRadius)
    }

    func setupLayout() {
        let stack = UIStackView()
        stack.setup(axis: .vertical, alignment: .fill, distribution: .fill, spacing: Constant.stackItemsSpacing)
        stack.addCentered(logoImageView, width: Constant.logoImageSide, height: Constant.logoImageSide)
        stack.addSpacer()
        stack.addArranged(nicknameTextField, size: Constant.textFieldHeight)
        stack.addArranged(tokenTextField, size: Constant.textFieldHeight)
        stack.addArranged(doneButton, size: Constant.doneButtonHeight)
        
        addSubview(stack, withEdgeInsets: Constant.stackEdgeInsetsSpacing, safeArea: true, bottomToKeyboard: true)
    }
}

// MARK: - View constants
private enum Constant {
    static let stackEdgeInsetsSpacing: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    static let stackItemsSpacing: CGFloat = 16
    static let textFieldHeight: CGFloat = 50
    static let doneButtonHeight: CGFloat = 50
    static let doneButtonCornerRadius: CGFloat = 12
    static let logoImageSide: CGFloat = UIScreen.main.bounds.width * 0.6
}

#if DEBUG
import SwiftUI
struct CredentialsPreview: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable(CredentialsView())
    }
}
#endif
