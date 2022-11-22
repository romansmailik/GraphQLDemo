//
//  RepositoryDisplayOption.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Foundation

enum RepositoryDisplayOption: CaseIterable {
    case latest
    case top
    
    var title: String {
        switch self {
        case .latest:
            return "Latest"
        case .top:
            return "Top"
        }
    }
}
