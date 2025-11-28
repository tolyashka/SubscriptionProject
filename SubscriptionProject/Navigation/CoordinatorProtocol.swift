//
//  Coordinator.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 26.11.2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
        parentCoordinator = nil
    }
    
    func start(coordinator: Coordinator, parent: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = parent
        coordinator.start()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
