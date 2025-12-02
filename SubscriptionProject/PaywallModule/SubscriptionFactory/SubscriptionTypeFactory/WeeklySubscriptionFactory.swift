//
//  WeeklySubscriptionFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 01.12.2025.
//

struct WeeklySubscriptionFactory: ISubscriptionFactory {
    private let priceOptionFactory: PriceOptionFactory

    init(priceOptionFactory: PriceOptionFactory) {
        self.priceOptionFactory = priceOptionFactory
    }

    func make() -> PaywallStatable {
        let price = priceOptionFactory.make(defaultPrice: 290.0)
        let undiscountedState = UndiscountedState(priceOptions: price)
        return WeeklySubscription(
            paywallOptions: PaywallOptions(
                title: "Недельная подписка",
                description: "Недельная подписка позволяет вам пользоваться всеми дополнительными функциями нашего приложения бесплатно в течение одной недели."
            ), priceDisplayState: undiscountedState
        )
    }
}
