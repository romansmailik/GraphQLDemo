//
//  CredentialsService.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 20.11.2022.
//

import Foundation

protocol CredentialsService {
    var credentials: Credentials? { get }
    
    func save(_ credentials: Credentials)
    func clear()
}

final class CredentialsServiceImpl: CredentialsService {
    
    var credentials: Credentials?
    
    private let defaults = UserDefaults.standard
    
    init() {
        if let data = defaults.object(forKey: Keys.credentials) as? Data,
           let credentialsModel = try? JSONDecoder().decode(Credentials.self, from: data) {
            self.credentials = credentialsModel
        } else {
            self.credentials = nil
        }
    }
    
    func save(_ credentials: Credentials) {
        self.credentials = credentials
        guard let credentialsData = try? JSONEncoder().encode(credentials) else {
            return
        }
        defaults.set(credentialsData, forKey: Keys.credentials)
    }
    
    func clear() {
        credentials = nil
        defaults.removeObject(forKey: Keys.credentials)
    }
}

private extension CredentialsServiceImpl {
    enum Keys {
        static let credentials = "github.credentials.key"
    }
}
