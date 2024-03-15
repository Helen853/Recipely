// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор
final class AppCoordinator: BaseCoordinator {
    private var mainTabBarController: MainTabBarController?
    private var appBuilder = MainTabBarBuilder()
    var net = NetworkService()

    override func start() {
        showMainTabBar()
    }

    func showMainTabBar() {
        mainTabBarController = MainTabBarController()
        let recipesCoordinator = RecipesCoordinator()
        let recipesModule = appBuilder.makeRecipesViewController(coordinator: recipesCoordinator)
        recipesCoordinator.setRootViewController(view: recipesModule)
        add(coordinator: recipesCoordinator)

        guard let recipesView = recipesCoordinator.rootViewController else { return }

        let favoritesCoordinator = FavoritesCoordinator()
        let favoritesModule = appBuilder.makeFavoritesViewController(coordinator: favoritesCoordinator)
        favoritesCoordinator.setRootViewController(view: favoritesModule)
        add(coordinator: favoritesCoordinator)

        guard let favoriteView = favoritesCoordinator.rootViewController else { return }

        let profileCoordinator = ProfileCoordinator()
        let profileModule = appBuilder.makeProfileViewController(coordinator: profileCoordinator)
        profileCoordinator.setRootViewController(view: profileModule)
        add(coordinator: profileCoordinator)

        guard let profileView = profileCoordinator.rootViewController else { return }

        mainTabBarController?.setViewControllers(
            [
                recipesView,
                favoriteView,
                profileView
            ],
            animated: true
        )

        guard let tabBarViewController = mainTabBarController else { return }
        setAsRoot​(​_​: tabBarViewController)
    }

    private func showLoginModule() {
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.goToTabBarController = { [weak self] in
            self?.remove(coordinator: loginCoordinator)
            self?.showMainTabBar()
        }
        add(coordinator: loginCoordinator)
        loginCoordinator.start()
    }
}
