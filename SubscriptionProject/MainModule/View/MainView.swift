//
//  MainView.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import UIKit

final class MainView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews() 
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureViews() {
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
