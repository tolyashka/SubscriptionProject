//
//  WithoutDiscount.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 29.11.2025.
//

import UIKit

final class UndiscountedState: UndiscountableState {
    let priceOptions: PriceOptions
    let isHidden: Bool
    let backgroundColor: UIColor
    let textColor: UIColor
    
    init(priceOptions: PriceOptions,
         isHidden: Bool = true,
         backgroundColor: UIColor = .systemRed.withAlphaComponent(0.1),
         textColor: UIColor = .systemRed
    ) {
        self.priceOptions = priceOptions
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
