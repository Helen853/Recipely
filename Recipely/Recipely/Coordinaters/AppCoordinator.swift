// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

/// Главный координатор
final class AppCoordinator: BaseCoordinator {
    private var mainTabBarController: MainTabBarController?
    private var appBuilder = MainTabBarBuilder()

    override func start() {
        if "admin" == "admin" {
            showMainTabBar()
        } else {
            showLoginModule()
        }
    }

    private func showMainTabBar() {
        mainTabBarController = MainTabBarController()

        let recipesModule = appBuilder.makeRecipesViewController()
        let recipesCoordinator = RecipesCoordinator(rootViewController: recipesModule)
        recipesModule.recipesPresenter?.coordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        let favoritesModule = appBuilder.makeFavoritesViewController()
        let favoritesCoordinator = FavoritesCoordinator(rootViewController: favoritesModule)
        favoritesModule.fvoritesPresenter?.favoritesCoordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        let profileModule = appBuilder.makeProfileViewController()
        let profileCoordinator = ProfileCoordinator(rootViewController: profileModule)
        profileModule.profilePresenter?.profileCoordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        mainTabBarController?.setViewControllers(
            [
                recipesCoordinator.rootViewController,
                favoritesCoordinator.rootViewController,
                profileCoordinator.rootViewController
            ],
            animated: true
        )

        guard let tabBarViewController = mainTabBarController else { return }
        setAsRoot​(​_​: tabBarViewController)
    }

    private func showLoginModule() {
        let loginCoordinator = LoginCoordinator()
        add(coordinator: loginCoordinator)
        loginCoordinator.start()
    }
}
