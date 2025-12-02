//
//  ConfigurationStorage.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import Foundation

protocol SavableConfiguration: AnyObject {
    func save<StoredType: Codable>(storedValue: StoredType, for key: StorageIdentifier)
}

final class SaverConfiguration: SavableConfiguration {
    private let storage: UserDefaults
    private let encoder: DataEncodable
    
    init(storage: UserDefaults, encoder: DataEncodable) {
        self.storage = storage
        self.encoder = encoder
    }
    
    func save<StoredType: Codable>(storedValue: StoredType, for key: StorageIdentifier) {
        guard let encodeData = try? encoder.encode(storedValue) else { return }
        storage.set(encodeData, forKey: key.rawValue)
    }
}
