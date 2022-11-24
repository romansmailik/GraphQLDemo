//
//  RepositoriesService.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Foundation
import Combine
import Apollo

enum NetworkError: Error {
    case noData
}

protocol RepositoriesService {
    func getLatestRepositories(username: String) -> AnyPublisher<[RepositoryDomainModel], Error>
    func getTopRatedRepositories(username: String) -> AnyPublisher<[RepositoryDomainModel], Error>
    func createRepository(_ model: CreateRepositoryModel) -> AnyPublisher<Void, Error>
}

final class RepositoriesServiceImpl: RepositoriesService {
    let apolloClient: ApolloClient
    
    init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient
    }
    
    func getLatestRepositories(username: String) -> AnyPublisher<[RepositoryDomainModel], Error> {
        return Future<[RepositoryDomainModel], Error> { [weak self] promise in
            guard let self = self else { return }
            self.apolloClient.fetch(query: GetRepositoriesByUserNameQuery(username: username), cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let nodes = graphQLResult.data?.user?.repositories.nodes else {
                        promise(.failure(NetworkError.noData))
                        return
                    }
                    let repositories = nodes
                        .compactMap { $0?.fragments.nodeDetails }
                        .map { RepositoryDomainModel(response: $0) }
                    
                    promise(.success(repositories))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getTopRatedRepositories(username: String) -> AnyPublisher<[RepositoryDomainModel], Error> {
        return Future<[RepositoryDomainModel], Error> { [weak self] promise in
            guard let self = self else { return }
            self.apolloClient.fetch(query: GetTopRepositoriesForUserQuery(username: username), cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let nodes = graphQLResult.data?.user?.repositories.nodes else {
                        promise(.failure(NetworkError.noData))
                        return
                    }
                    let repositories = nodes
                        .compactMap { $0?.fragments.nodeDetails }
                        .map { RepositoryDomainModel(response: $0) }
                    
                    promise(.success(repositories))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func createRepository(_ model: CreateRepositoryModel) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            self.apolloClient.perform(mutation: CreateRepositoryMutation(name: model.title, description: model.description, visibility: model.scope.repositoryVisibility, clientMutationId: UUID().uuidString)) { result in
                switch result {
                case .success(let graphQLResult) :
                    if let error = graphQLResult.errors?.first {
                        promise(.failure(error))
                        return
                    }
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
