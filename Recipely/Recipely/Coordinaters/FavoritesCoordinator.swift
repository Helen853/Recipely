// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор фаворитов
final class FavoritesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootViewController(view: UIViewController) {
        rootViewController = UINavigationController(rootViewController: view)
    }
}
