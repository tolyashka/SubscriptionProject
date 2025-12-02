//
//  YearlySubscriptionFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 01.12.2025.
//

struct YearlySubscriptionFactory: ISubscriptionFactory {
    private let priceOptionFactory: PriceOptionFactory
    private let discountCalculatorFactory: IDiscountCalculatorFactory

    init(
        priceOptionFactory: PriceOptionFactory,
        discountCalculatorFactory: IDiscountCalculatorFactory
    ) {
        self.priceOptionFactory = priceOptionFactory
        self.discountCalculatorFactory = discountCalculatorFactory
    }
    
    func make() -> PaywallStatable {
        let calculator = discountCalculatorFactory.make()
        let priceOptions = PriceOptions(defaultPrice: 3480.0)
        let discountedPrice = calculator.calculate(with: priceOptions)
        let discountedState = DiscountedState(priceOptions: discountedPrice)
        let paywallOptions = PaywallOptions(title: "Годовая подписка", description: "Годовая подписка позволяет вам пользоваться всеми дополнительными функциями нашего приложения бесплатно в течение одного года. Годовая подписка доступна со скидкой.")
        return YearlySubscription(paywallOptions: paywallOptions, priceDisplayState: discountedState)
    }
}
