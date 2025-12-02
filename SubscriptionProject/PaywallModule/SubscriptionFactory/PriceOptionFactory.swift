//
//  PriceOptionFactory.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 01.12.2025.
//

protocol IPriceOptionFactory {
    func make(defaultPrice: Double) -> PriceOptions
    func make(discountPrice: Double, defaultPrice: Double) -> DiscountOptions
}

final class PriceOptionFactory: IPriceOptionFactory {
    func make(defaultPrice: Double) -> PriceOptions {
        PriceOptions(defaultPrice: defaultPrice)
    }

    func make(discountPrice: Double, defaultPrice: Double) -> DiscountOptions {
        DiscountOptions(
            defaultPrice: defaultPrice,
            discountPrice: discountPrice
        )
    }
}
