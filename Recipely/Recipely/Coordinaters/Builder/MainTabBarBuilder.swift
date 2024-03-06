// MainTabBarBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер таббара
final class MainTabBarBuilder {
    func makeRecipesViewController(coordinator: RecipesCoordinator) -> RecipesViewController {
        let recipesViewController = RecipesViewController()
        let recipesPresenter = RecipesPresenter(view: recipesViewController, coordinator: coordinator)
        recipesViewController.recipesPresenter = recipesPresenter
        recipesViewController.tabBarItem = UITabBarItem(
            title: AppConstants.recipes,
            image: UIImage(named: AppConstants.recipes),
            tag: 0
        )
        return recipesViewController
    }

    func makeFavoritesViewController(coordinator: FavoritesCoordinator) -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(view: favoritesViewController, coordinator: coordinator)
        favoritesViewController.fvoritesPresenter = favoritesPresenter
        favoritesViewController.tabBarItem = UITabBarItem(
            title: AppConstants.favorites,
            image: UIImage(named: AppConstants.favorites),
            tag: 1
        )
        return favoritesViewController
    }

    func makeProfileViewController(coordinator: ProfileCoordinator) -> ProfileViewController {
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: profileViewController, coordinator: coordinator)
        profileViewController.profilePresenter = profilePresenter
        profileViewController.tabBarItem = UITabBarItem(
            title: AppConstants.profile,
            image: UIImage(named: AppConstants.profile),
            tag: 2
        )
        return profileViewController
    }

    func makeCategoryViewcontroller() -> CategoryViewController {
        let categoryViewController = CategoryViewController()
        let categoryPresenter = CategoryPresenter(view: categoryViewController)
        categoryViewController.categoryPresenter = categoryPresenter
        return categoryViewController
    }

    func makeRecipeDetailViewController() -> RecipeDetailViewController {
        let recipeDetailViewController = RecipeDetailViewController()
        let detailPresenter = RecipeDetailPresenter(view: recipeDetailViewController)
        recipeDetailViewController.recipeDetailPresenter = detailPresenter
        return recipeDetailViewController
    }
}
