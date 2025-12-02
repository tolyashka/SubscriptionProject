//
//  ConfigurationStorage.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import Foundation

enum StorageIdentifier: String, Codable {
    case selectedItems
}

typealias IConfigurationStorage = LoadableConfiguration & SavableConfiguration

final class ConfigurationStorage: IConfigurationStorage {

    private let loader: LoadableConfiguration
    private let saver: SavableConfiguration

    init(loader: LoadableConfiguration,
         saver: SavableConfiguration) {
        self.loader = loader
        self.saver = saver
    }

    func get<StoredType: Codable>(
         type: StoredType.Type,
         forKey key: StorageIdentifier) -> StoredType? {
        loader.get(type: type, forKey: key)
    }

    func save<StoredType: Codable>(
         storedValue: StoredType,
         for key: StorageIdentifier) {
        saver.save(storedValue: storedValue, for: key)
    }
}
