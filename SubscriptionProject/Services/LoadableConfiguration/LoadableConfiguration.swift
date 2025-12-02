//
//  LoadableConfiguration.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import Foundation

protocol LoadableConfiguration: AnyObject {
    func get<StoredType: Codable>(
        type: StoredType.Type,
        forKey key: StorageIdentifier
    ) -> StoredType?
}

final class LoaderConfiguration: LoadableConfiguration {
    private let storage: UserDefaults
    private let decoder: DataDecodable
    
    init(storage: UserDefaults, decoder: DataDecodable) {
        self.storage = storage
        self.decoder = decoder
    }
    
    func get<StoredType: Codable>(
        type: StoredType.Type,
        forKey key: StorageIdentifier
    ) -> StoredType? {
        guard let storedData = storage.data(forKey: key.rawValue) else { return nil }
        let decodeData = try? decoder.decode(type.self, from: storedData)
        return decodeData
    }
}
