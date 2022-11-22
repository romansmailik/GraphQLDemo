//
//  RepositoryTableViewCell.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {
    private let infoStack = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let starStack = UIStackView()
    private let starsLabel = UILabel()
    private let starImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    func setup() {
        titleLabel.text = "Title"
        descriptionLabel.text = "Description"
        starsLabel.text = "\(Int.random(in: 1...5))"
    }
}

private extension RepositoryTableViewCell {
    func initialSetup() {
        setupLayout()
        setupUI()
    }
    
    func setupUI() {
        starImageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow)
        
//        infoStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        infoStack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        starStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        starStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
//        infoStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        infoStack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        starStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        starStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func setupLayout() {
        infoStack.setup(spacing: 8)
        infoStack.addArranged(titleLabel)
        infoStack.addArranged(descriptionLabel)
        
        starStack.setup(axis: .horizontal, alignment: .center, spacing: 2)
        starStack.addArranged(starsLabel, size: 12)
        starStack.addArranged(starImageView, width: 20, height: 20)
        
        let contentStack = UIStackView()
        contentStack.setup(axis: .horizontal, alignment: .firstBaseline, distribution: .fill, spacing: 4)
        contentStack.addArranged(infoStack)
        contentStack.addArranged(starStack)
        contentView.addSubview(contentStack, withEdgeInsets: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
}
