//
//  AppStateFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

protocol AppStateFactoryProtocol {
    func makeInitialState() -> AppState
}

final class AppStateFactory: AppStateFactoryProtocol {
    private let configurationStorage: IConfigurationStorage
    
    init(configurationStorage: IConfigurationStorage) {
        self.configurationStorage = configurationStorage
    }
    
    func makeInitialState() -> AppState {
        let result = configurationStorage.get(type: PaywallOptions.self, forKey: .selectedItems)
        
        return result == nil
            ? OnboardingState()
            : MainState()
    }
}
