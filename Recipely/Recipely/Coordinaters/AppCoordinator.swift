// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

/// Главный координатор
final class AppCoordinator: BaseCoordinator {
    private var tabBarViewController: MainTabBarController?
    private var appBuilder = Builder()

    override func start() {
        if "admin" != "admin" {
            tabBarMain()
        } else {
            t​oLogin()
        }
    }

    private func tabBarMain() {
        tabBarViewController = MainTabBarController()

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

        tabBarViewController?.setViewControllers(
            [
                recipesCoordinator.rootViewController,
                favoritesCoordinator.rootViewController,
                profileCoordinator.rootViewController
            ],
            animated: true
        )

        guard let tabBarViewController = tabBarViewController else { return }
        setAsRoot​(​_​: tabBarViewController)
    }

    private func t​oLogin() {
        let loginCoordinator = LoginCoordinator()
//        loginCoordinator.onFinishFlow = { [weak self] in
//            self?.remove(coordinator: loginCoordinator)
//            self?.​toMain​()
//        }
        add(coordinator: loginCoordinator)
        loginCoordinator.start()
    }
}
