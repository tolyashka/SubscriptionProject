//
//  YearlySubscription.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 27.11.2025.
//

import Foundation

final class YearlySubscription: PaywallStatable {
    let priceDisplayState: PriceDisplayState
    let paywallOptions: PaywallOptions
    
    init(paywallOptions: PaywallOptions,
         priceDisplayState: PriceDisplayState) {
        self.paywallOptions = paywallOptions
        self.priceDisplayState = priceDisplayState
    }
}
