//
//  MainModuleCoordinator.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func mainCoordinatorDidFinish(_ coordinator: MainCoordinator)
}

final class MainCoordinator: Coordinator {
    weak var delegate: MainCoordinatorDelegate?
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = makeViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }

    func finish() {
        delegate?.mainCoordinatorDidFinish(self)
        parentCoordinator?.removeChildCoordinator(self)
    }

    private func makeViewModel() -> MainViewModelProtocol {
        MainViewModel(mainModel: MainModel())
    }
}
