// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootViewController(view: UIViewController) {
        rootViewController = UINavigationController(rootViewController: view)
    }

    func pushDetailViewController(type: CategoryCellType) {
        let categoryVewController = MainTabBarBuilder().makeCategoryViewcontroller()
        categoryVewController.categoryPresenter?.coordinator = self
        categoryVewController.setupCategory(type)
        categoryVewController.hidesBottomBarWhenPushed = true
        rootViewController?.pushViewController(categoryVewController, animated: true)
    }

    func popRecipesViewController() {
        rootViewController?.popViewController(animated: true)
    }
}
