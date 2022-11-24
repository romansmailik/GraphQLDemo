//
//  RepositoryScopeOption.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 22.11.2022.
//

import Foundation

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
    
    var repositoryVisibility: RepositoryVisibility {
        switch self {
        case .private:
            return .private
        case .public:
            return .public
        }
    }
}
