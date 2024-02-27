// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// wew
class FavoritesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController

    init(rootViewController: UIViewController) {
        self.rootViewController = UINavigationController(rootViewController: rootViewController)
    }
}
