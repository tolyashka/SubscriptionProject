//
//  PaywallStatable.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 27.11.2025.
//

import Foundation

protocol PaywallStatable: AnyObject {
    var paywallOptions: PaywallOptions { get }
    var priceDisplayState: PriceDisplayState { get }
}
