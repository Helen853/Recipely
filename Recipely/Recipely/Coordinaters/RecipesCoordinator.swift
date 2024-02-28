// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// wew
class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController

    init(rootViewController: UIViewController) {
        self.rootViewController = UINavigationController(rootViewController: rootViewController)
    }

    func pushDetailViewController() {
        debugPrint("Переход на экран с рецептами")
    }
}