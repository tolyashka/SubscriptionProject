//
//  SubscriptionFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

protocol PaywallSubscribe {
    func makeSubscriptions() -> [PaywallStatable]
}

final class SubscriptionFactory: PaywallSubscribe {
    private let paywallFactory: PaywallFactory
    
    init(paywallFactory: PaywallFactory) {
        self.paywallFactory = paywallFactory
    }
    
    func makeSubscriptions() -> [PaywallStatable] {
        let weeklySubscription = paywallFactory.makeWeeklySubscription()
        let yearlySubscription = paywallFactory.makeYearlySubscription()
        return [weeklySubscription, yearlySubscription]
    }
}
