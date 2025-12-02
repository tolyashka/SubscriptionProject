//
//  OnboardingNavigation.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 26.11.2025.
//

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator)
}

final class OnboardingCoordinator: Coordinator {
    weak var delegate: OnboardingCoordinatorDelegate?

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let pages = makeOnboardingPages()
        let pageIndexService = PageIndexService(pages: pages)
        let viewModel = OnboardingViewModel(pages: pages, pageIndexService: pageIndexService)

        let pageViewController = OnboardingPageViewController(viewModel: viewModel)
        pageViewController.flowDelegate = self

        navigationController.setViewControllers([pageViewController], animated: false)
    }

    func finish() {
        delegate?.onboardingCoordinatorDidFinish(self)
        parentCoordinator?.removeChildCoordinator(self)
    }

    private func makeOnboardingPages() -> [OnboardingPage] {
        [
            OnboardingPage(
                title: "Добро пожаловать",
                description: "Это приложение поможет вам организовать вашу жизнь и достигать целей",
                imageName: "pencil.and.outline",
                buttonTitle: "Далее"
            ),
            OnboardingPage(
                title: "Отслеживайте прогресс",
                description: "Наблюдайте за вашими успехами с помощью красивых графиков и статистики",
                imageName: "pencil.and.outline",
                buttonTitle: "Далее"
            ),
            OnboardingPage(
                title: "Начните сейчас",
                description: "Присоединяйтесь к миллионам пользователей по всему миру",
                imageName: "pencil.and.outline",
                buttonTitle: "Начать использовать"
            )
        ]
    }
    
    private func startPaywallCoordinator() {
        let coordinator = PaywallCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)

        coordinator.start()
    }
}

extension OnboardingCoordinator: OnboardingPageViewControllerDelegate {
    func onboardingDidFinish() {
        finish()
        startPaywallCoordinator()
    }
}
