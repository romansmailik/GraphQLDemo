//
//  Collection+Safe.swift
//  GraphQLDemo
//
//  Created by Roman Savchenko on 22.11.2022.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
