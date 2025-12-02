//
//  PaywallOptionView.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 28.11.2025.
//

import UIKit

protocol PaywallOptionViewDelegate: AnyObject {
    func paywallOptionViewDidTap(_ view: PaywallOptionView)
}

final class PaywallOptionView: UIView {
    weak var delegate: PaywallOptionViewDelegate?
    
    private lazy var priceView: PriceView = {
        let view = PriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var componentsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                subTitleLabel,
                priceView
            ]
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setSelected(_ isSelected: Bool) {
        updateSelectionState(isSelected: isSelected)
    }
    
    func updateValues(with paywallState: PaywallStatable) {
        titleLabel.text = paywallState.paywallOptions.title
        subTitleLabel.text = paywallState.paywallOptions.description
        
        switch paywallState.priceDisplayState {
        case let state as DiscountableState:
            priceView.set(
                defaultPrice: String(state.priceOptions.defaultPrice),
                discountPrice: String(state.priceOptions.discountPrice)
            )
            priceView.setAttributedPrice(String(state.priceOptions.defaultPrice))
            priceView.apply(state: state)
            
        case let state as UndiscountableState:
            priceView.set(
                defaultPrice: String(state.priceOptions.defaultPrice),
                discountPrice: nil
            )
            priceView.apply(state: state)
        default:
            break
        }
    }
}

private extension PaywallOptionView {
    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        delegate?.paywallOptionViewDidTap(self)
    }
}

private extension PaywallOptionView {
    private func updateSelectionState(isSelected: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.layer.borderColor = isSelected
                ? UIColor.systemBlue.cgColor
                : UIColor.systemGray4.cgColor
            
            self.backgroundColor = isSelected
                ? UIColor.systemBlue.withAlphaComponent(0.12)
                : UIColor.secondarySystemBackground
        }
    }
    
    func configureViews() {
        clipsToBounds = true
        addSubview(componentsStackView)
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            componentsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            componentsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            componentsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            componentsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
