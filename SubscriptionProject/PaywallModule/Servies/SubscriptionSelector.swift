//
//  SubscriptionService.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 28.11.2025.
//

import Foundation

protocol ISubscriptionSelector {
    var selectedSubscription: PaywallStatable? { get }
    var availableSubscriptions: [PaywallStatable] { get }
    
    func selectSubscription(at index: Int)
}

final class SubscriptionSelector: ISubscriptionSelector {
    var availableSubscriptions: [PaywallStatable]
    var selectedSubscription: PaywallStatable?

    init(subscriptions: [PaywallStatable]) {
        self.availableSubscriptions = subscriptions
    }

    func selectSubscription(at index: Int) {
        guard checkCorrectIndex(index) else { return }
        selectedSubscription = availableSubscriptions[index]
    }
    
    private func checkCorrectIndex(_ index: Int) -> Bool {
        (index >= 0) && (index < availableSubscriptions.count)
    }
}
