//
//  MainState.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

final class MainState: AppState {
    func start(in coordinator: ApplicationCoordinator) {
        coordinator.showMainModule()
    }
}
