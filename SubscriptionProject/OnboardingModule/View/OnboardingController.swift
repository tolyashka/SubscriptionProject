//
//  View.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 26.11.2025.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingViewControllerDidTapNext(_ controller: OnboardingViewController)
    func onboardingViewControllerDidRequestSkip(_ controller: OnboardingViewController)
}

final class OnboardingViewController: UIViewController {
    weak var delegate: OnboardingViewControllerDelegate?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()

    private lazy var nextOnbordingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                imageView, titleLabel, descriptionLabel, nextOnbordingButton
            ]
        )
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    func updateValues(with page: OnboardingPage) {
        imageView.image = UIImage(systemName: page.imageName)
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        nextOnbordingButton.setTitle(page.buttonTitle, for: .normal)
    }

    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        configureLayoutConstraints()
        nextOnbordingButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250),

            nextOnbordingButton.heightAnchor.constraint(equalToConstant: 50),
            nextOnbordingButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    @objc private func nextTapped() {
        delegate?.onboardingViewControllerDidTapNext(self)
    }
}
