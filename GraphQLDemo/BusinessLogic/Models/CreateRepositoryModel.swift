//
//  CreateRepositoryModel.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 24.11.2022.
//

import Foundation

struct CreateRepositoryModel {
    let title: String
    let description: String?
    let scope: RepositoryScopeOption
}
