// LoginCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана авторизации
final class LoginCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    override func start() {
        showLogin()
    }

    func showLogin() {
        let loginCoordinator = LoginCoordinator()
        let loginViewController = LoginViewController()
        let loginPresenter = LoginPresenter(view: loginViewController, coordinator: loginCoordinator)
        loginViewController.loginPresenter = loginPresenter

        let rootViewController = UINavigationController(rootViewController: loginViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }
}
