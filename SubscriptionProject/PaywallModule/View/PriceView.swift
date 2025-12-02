//
//  DiscountView.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 29.11.2025.
//

import UIKit

final class PriceView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 30)
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                discountPriceLabel,
                defaultPriceLabel
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var defaultPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var discountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PriceView {
    func apply(state: PriceDisplayState) {
        discountPriceLabel.textColor = state.textColor
        discountPriceLabel.isHidden = state.isHidden
        backgroundColor = state.backgroundColor
    }
    
    func set(defaultPrice: String, discountPrice: String?) {
        defaultPriceLabel.text = defaultPrice
        discountPriceLabel.text = discountPrice
    }
    
    func setAttributedPrice(_ text: String?) {
        guard let text else {
            defaultPriceLabel.attributedText = nil
            return
        }
        
        let attributed = NSAttributedString(
            string: text,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: defaultPriceLabel.textColor,
                .baselineOffset: 0
            ]
        )
        
        defaultPriceLabel.attributedText = attributed
    }
}

private extension PriceView {
    func configureViews() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(stackView)
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
