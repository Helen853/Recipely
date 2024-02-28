// LoginCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ere
class LoginCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    override func start() {
        showLogin()
    }

    func showLogin() {
        let loginViewController = LoginViewController()
        let loginPresenter = LoginPresenter(view: loginViewController)
        loginViewController.loginPresenter = loginPresenter
        loginPresenter.loginCoordinator = self

        let rootViewController = UINavigationController(rootViewController: loginViewController)
        setAsRoot​(​_​: rootViewController)
        self.rootViewController = rootViewController
    }
}
