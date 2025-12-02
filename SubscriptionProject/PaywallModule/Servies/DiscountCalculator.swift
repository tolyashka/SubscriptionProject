//
//  DiscountCalculator.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 29.11.2025.
//

import Foundation

protocol IDiscountCalculator {
    func change(percentage: PercentageOptions)
    func calculate(with option: PriceOptions) -> DiscountOptions
}

final class DiscountCalculator: IDiscountCalculator {
    private let maximalPercentage = 100.0
    private var percentageOptions: PercentageOptions
    
    init(percentageOptions: PercentageOptions) {
        self.percentageOptions = percentageOptions
    }
    
    func change(percentage: PercentageOptions) {
        self.percentageOptions = percentage
    }
    
    func calculate(with priceOption: PriceOptions) -> DiscountOptions {
        calculatePercentage(for: priceOption)
    }
    
    private func calculatePercentage(for priceOptions: PriceOptions) -> DiscountOptions {
        let discount = priceOptions.defaultPrice * (percentageOptions.percentage / maximalPercentage)
        let resultPrice = priceOptions.defaultPrice - discount
        let priceOptions = DiscountOptions(defaultPrice: priceOptions.defaultPrice, discountPrice: resultPrice)
        return priceOptions
    }
}

