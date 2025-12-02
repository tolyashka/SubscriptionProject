//
//  DiscountState.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 29.11.2025.
//

import UIKit

protocol PriceDisplayState {
    var isHidden: Bool { get }
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

protocol DiscountableState: PriceDisplayState {
    var priceOptions: DiscountOptions { get }
}

protocol UndiscountableState: PriceDisplayState {
    var priceOptions: PriceOptions { get }
}
