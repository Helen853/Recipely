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

    func showRecipeDetailViewController() {
        let recipeDetailViewController = MainTabBarBuilder().makeRecipeDetailViewController()
        recipeDetailViewController.recipeDetailPresenter?.coordinator = self
        rootViewController?.pushViewController(recipeDetailViewController, animated: true)
    }

    func popDetailViewController() {
        rootViewController?.popViewController(animated: true)
    }
}
