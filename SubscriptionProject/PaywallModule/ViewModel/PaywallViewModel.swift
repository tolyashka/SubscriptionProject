//
//  PaywallViewModel.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 28.11.2025.
//

import Foundation

protocol PaywallViewModelProtocol {
    var availableSubscriptions: [PaywallStatable] { get }
    var selectedSubscription: PaywallStatable? { get }
    
    func selectItem(at index: Int)
    func save(subscription: PaywallOptions)
}

final class PaywallViewModel {
    private let subscriptionSelector: ISubscriptionSelector
    private let configurationStorage: IConfigurationStorage
    
    init(subscriptionService: ISubscriptionSelector,
         configurationStorage: IConfigurationStorage) {
        self.subscriptionSelector = subscriptionService
        self.configurationStorage = configurationStorage
    }
}

extension PaywallViewModel: PaywallViewModelProtocol {
    var selectedSubscription: PaywallStatable? {
        subscriptionSelector.selectedSubscription
    }
    
    var availableSubscriptions: [PaywallStatable] {
        subscriptionSelector.availableSubscriptions
    }
   
    func selectItem(at index: Int) {
        subscriptionSelector.selectSubscription(at: index)
    }
    
    func save(subscription: PaywallOptions) {
        configurationStorage.save(storedValue: subscription, for: .selectedItems)
    }
}
