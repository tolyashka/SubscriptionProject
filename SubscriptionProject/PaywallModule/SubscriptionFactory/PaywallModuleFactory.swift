//
//  PaywallModuleFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

protocol IPaywallModuleFactory {
    func makeViewModel() -> PaywallViewModelProtocol
}

final class PaywallModuleFactory: IPaywallModuleFactory {
    private let subscriptionFactory: SubscriptionFactory
    private let configurationStorage: IConfigurationStorageFactory
    
    init(subscriptionFactory: SubscriptionFactory = SubscriptionFactory(paywallFactory: DefaultPaywallFactory()),
         configurationStorage: IConfigurationStorageFactory = ConfigurationStorageFactory()) {
        self.subscriptionFactory = subscriptionFactory
        self.configurationStorage = configurationStorage
    }
    
    func makeViewModel() -> PaywallViewModelProtocol {
        let subscriptions = subscriptionFactory.makeSubscriptions()
        let service = SubscriptionSelector(subscriptions: subscriptions)
        let configuration = configurationStorage.make()
        
        return PaywallViewModel(subscriptionService: service, configurationStorage: configuration)
    }
}
