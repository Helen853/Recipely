// Builder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// wew
class Builder {
    func makeRecipesViewController() -> RecipesViewController {
        let recipesViewController = RecipesViewController()
        let recipesPresenter = ReciperPresenter(view: recipesViewController)
        recipesViewController.recipesPresenter = recipesPresenter
        recipesViewController.tabBarItem = UITabBarItem(
            title: AppConstants.recipes,
            image: UIImage(named: AppConstants.recipes),
            tag: 0
        )
        return recipesViewController
    }

    func makeFavoritesViewController() -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        let favoritesPresenter = FavoritesPresenter(view: favoritesViewController)
        favoritesViewController.fvoritesPresenter = favoritesPresenter
        favoritesViewController.tabBarItem = UITabBarItem(
            title: AppConstants.favorites,
            image: UIImage(named: AppConstants.favorites),
            tag: 1
        )
        return favoritesViewController
    }

    func makeProfileViewController() -> ProfileViewController {
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: profileViewController)
        profileViewController.profilePresenter = profilePresenter
        profileViewController.tabBarItem = UITabBarItem(
            title: AppConstants.profile,
            image: UIImage(named: AppConstants.profile),
            tag: 2
        )
        return profileViewController
    }
}
