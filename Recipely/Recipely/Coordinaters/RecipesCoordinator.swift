// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор рецептов
final class RecipesCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootViewController(view: UIViewController) {
        rootViewController = UINavigationController(rootViewController: view)
    }

    func pushDetailViewController(type: DishType) {
        let categoryVewController = MainTabBarBuilder().makeCategoryViewcontroller()
        categoryVewController.categoryPresenter?.coordinator = self
        categoryVewController.setupCategory(type)
        categoryVewController.hidesBottomBarWhenPushed = true
        rootViewController?.pushViewController(categoryVewController, animated: true)
    }

    func popRecipesViewController() {
        rootViewController?.popViewController(animated: true)
    }

    func showRecipeDetailViewController(model: Recipes) {
        let recipeDetailViewController = MainTabBarBuilder().makeRecipeDetailViewController()
        recipeDetailViewController.recipeDetailPresenter?.coordinator = self
        recipeDetailViewController.setupSaveButton(title: model.foodName)
        recipeDetailViewController.setupCell(model: model)
        rootViewController?.pushViewController(recipeDetailViewController, animated: true)
    }

    func popDetailViewController() {
        rootViewController?.popViewController(animated: true)
    }
}
