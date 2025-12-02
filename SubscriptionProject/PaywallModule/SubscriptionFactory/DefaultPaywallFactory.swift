//
//  DefaultPaywallFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 29.11.2025.
//

protocol ISubscriptionFactory {
    func make() -> PaywallStatable
}

protocol PaywallFactory {
    func makeWeeklySubscription() -> PaywallStatable
    func makeYearlySubscription() -> PaywallStatable
}
 
final class DefaultPaywallFactory: PaywallFactory {
    private let priceOptionFactory = PriceOptionFactory()
    private let discountCalculatorFactory: IDiscountCalculatorFactory = DiscountCalculatorFactory()

    func makeWeeklySubscription() -> PaywallStatable {
        WeeklySubscriptionFactory(priceOptionFactory: priceOptionFactory)
            .make()
    }

    func makeYearlySubscription() -> PaywallStatable {
        YearlySubscriptionFactory(
            priceOptionFactory: priceOptionFactory,
            discountCalculatorFactory: discountCalculatorFactory
        )
        .make()
    }
}
