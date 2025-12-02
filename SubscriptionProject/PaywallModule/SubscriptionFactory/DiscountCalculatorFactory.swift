//
//  DiscountCalculatorFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 01.12.2025.
//

protocol IDiscountCalculatorFactory {
    func make() -> IDiscountCalculator
}

struct DiscountCalculatorFactory: IDiscountCalculatorFactory {
    func make() -> IDiscountCalculator {
        let percentageOptions = PercentageOptions(percentage: 20.0)
        let discountCalculator = DiscountCalculator(percentageOptions: percentageOptions)
        return discountCalculator
    }
}
