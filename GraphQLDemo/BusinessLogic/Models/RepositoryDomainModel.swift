//
//  RepositoryDomainModel.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 24.11.2022.
//

import Foundation

struct RepositoryDomainModel {
    let id: String
    let title: String
    let description: String?
    let starsCount: Int
    
    init(id: String, title: String, description: String? = nil, starsCount: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.starsCount = starsCount
    }
    
    init(response: NodeDetails) {
        self.id = response.id
        self.title = response.name
        self.description = response.description
        self.starsCount = response.stargazerCount
    }
}
