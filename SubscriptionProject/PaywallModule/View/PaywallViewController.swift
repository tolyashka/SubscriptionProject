//
//  PaywallViewController.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 28.11.2025.
//

import UIKit

protocol PaywallFlowDelegate: AnyObject {
    func paywallDidPurchase()
    func paywallDidClose()
}

final class PaywallViewController: UIViewController {
    weak var flowDelegate: PaywallFlowDelegate?
    
    private let viewModel: PaywallViewModelProtocol
    private var optionViews: [PaywallOptionView] = []
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
        return button
    }()

    init(viewModel: PaywallViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupOptions()
    }

    private func setupOptions() {
        for index in viewModel.availableSubscriptions.indices {
            configureSubscriptionView(with: index)
        }
    }
    
    private func configureSubscriptionView(with index: Int) {
        let option = PaywallOptionView()
        option.layer.borderWidth = 2
        option.layer.borderColor = UIColor.systemGray5.cgColor
        option.layer.cornerRadius = 15
        option.delegate = self
        option.tag = index
        option.updateValues(with: viewModel.availableSubscriptions[index])
        optionViews.append(option)
        
        stackView.addArrangedSubview(option)
    }

    @objc private func onContinue() {
        guard let selectedSubscription = viewModel.selectedSubscription else { return }
        viewModel.save(subscription: selectedSubscription.paywallOptions)
        flowDelegate?.paywallDidPurchase()
    }
}

extension PaywallViewController: PaywallOptionViewDelegate {
    func paywallOptionViewDidTap(_ view: PaywallOptionView) {
        let index = view.tag
        viewModel.selectItem(at: index)
        
        for (selectedIndex, selectedView) in optionViews.enumerated() {
            selectedView.setSelected(selectedIndex == index)
        }
    }
}

private extension PaywallViewController {
    func configureViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(continueButton)
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
