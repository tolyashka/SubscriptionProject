//
//  ApplicationCoordinator.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 26.11.2025.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private let window: UIWindow?
    private let appState: AppState

    init(window: UIWindow?,
         navigationController: UINavigationController,
         appStateFactory: AppStateFactoryProtocol) {

        self.window = window
        self.navigationController = navigationController
        self.appState = appStateFactory.makeInitialState()
    }

    func start() {
        appState.start(in: self)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension ApplicationCoordinator {
    func showOnboardingCoordinator() {
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController
        )
        start(coordinator: onboardingCoordinator, parent: self)
    }

    func showMainModule() {
        let mainModuleCoordinator = MainCoordinator(navigationController: navigationController)
        start(coordinator: mainModuleCoordinator, parent: self)
    }
}
