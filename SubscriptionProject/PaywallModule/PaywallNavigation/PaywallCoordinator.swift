//
//  PaywallCoordinator.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 28.11.2025.
//

import UIKit

final class PaywallCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let paywallFactory: IPaywallModuleFactory
    
    init(navigationController: UINavigationController,
         paywallFactory: IPaywallModuleFactory = PaywallModuleFactory()
    ) {
        self.navigationController = navigationController
        self.paywallFactory = paywallFactory
    }
    
    func start() {
        let viewModel = makeViewModel()
        let viewController = PaywallViewController(viewModel: viewModel)
        viewController.flowDelegate = self

        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    private func makeViewModel() -> PaywallViewModelProtocol {
        paywallFactory.makeViewModel()
    }
    
    private func startMainCoordinator() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
}

extension PaywallCoordinator: PaywallFlowDelegate {
    func paywallDidPurchase() {
        startMainCoordinator()
        finish()
    }
    
    func paywallDidClose() {
        finish()
    }
}
