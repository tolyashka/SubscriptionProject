//
//  ConfigurationStorageFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import Foundation

protocol IConfigurationStorageFactory {
    func make() -> IConfigurationStorage
}

final class ConfigurationStorageFactory: IConfigurationStorageFactory {
    func make() -> IConfigurationStorage {
        lazy var storage = UserDefaults.standard
        lazy var decoder = JSONDecoder()
        lazy var encoder = JSONEncoder()
        
        let loader = LoaderConfiguration(storage: storage, decoder: decoder)
        let saver = SaverConfiguration(storage: storage, encoder: encoder)
        
        return ConfigurationStorage(loader: loader, saver: saver)
    }
}
