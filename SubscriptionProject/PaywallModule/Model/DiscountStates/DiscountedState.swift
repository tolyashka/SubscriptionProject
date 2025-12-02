//
//  DiscountAvailableState.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 29.11.2025.
//

import UIKit

final class DiscountedState: DiscountableState {
    let priceOptions: DiscountOptions
    let isHidden: Bool
    let backgroundColor: UIColor
    let textColor: UIColor

    init(
        priceOptions: DiscountOptions,
        isHidden: Bool = false,
        backgroundColor: UIColor = .systemGreen.withAlphaComponent(0.1),
        textColor: UIColor = .systemGreen
    ) {
        self.priceOptions = priceOptions
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
