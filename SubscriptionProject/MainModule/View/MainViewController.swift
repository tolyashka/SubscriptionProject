//
//  MainViewController.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import UIKit

final class MainViewController: UIViewController {

    private let viewModel: MainViewModelProtocol
    private let mainView = MainView()

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        mainView.titleLabel.text = viewModel.titleText
    }
}
