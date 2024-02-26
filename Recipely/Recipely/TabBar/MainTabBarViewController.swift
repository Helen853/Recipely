// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// TabBar
class MainTabBarController: UITabBarController {
    // MARK: - Private Methods

    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: RecipesViewController(),
                title: AppConstants.recipes,
                image: UIImage(named: AppConstants.recipes)
            ),

            generateVC(
                viewController: FavoritesViewController(),
                title: AppConstants.favorites,
                image: UIImage(named: AppConstants.favorites)
            ),

            generateVC(
                viewController: ProfileViewController(),
                title: AppConstants.profile,
                image: UIImage(named: AppConstants.profile)
            )
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }

    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = #colorLiteral(red: 0.5131713152, green: 0.7742882967, blue: 0.7948206067, alpha: 1)
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .white
    }
}
