//
//  OnboardingState.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

final class OnboardingState: AppState {
    func start(in coordinator: ApplicationCoordinator) {
        coordinator.showOnboardingCoordinator()
    }
}
