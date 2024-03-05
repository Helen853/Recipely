// LoginCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана авторизации
final class LoginCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var goToTabBarController: VoidHandler?

    override func start() {
        showLogin()
    }

    func goToTabBarScreen() {
        goToTabBarController?()
    }

    func showLogin() {
        let loginViewController = LoginViewController()
        let loginPresenter = LoginPresenter(view: loginViewController, coordinator: self)
        loginViewController.loginPresenter = loginPresenter

        let rootViewController = UINavigationController(rootViewController: loginViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }
}
