// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Координатор профиля
final class ProfileCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController

    init(rootViewController: UIViewController) {
        self.rootViewController = UINavigationController(rootViewController: rootViewController)
    }

    func presentTemsPolicyController() {
        print("Показываем экран с текстом")
    }
}
