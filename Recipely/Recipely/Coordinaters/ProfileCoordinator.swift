// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор профиля
final class ProfileCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootViewController(view: UIViewController) {
        rootViewController = UINavigationController(rootViewController: view)
    }

    func presentBonusesController() {
        let bonusesViewController = BonusesViewController()
        let bonusesPresenter = BonusesPresenter(view: bonusesViewController)
        bonusesViewController.bonusesPresenter = bonusesPresenter
        bonusesPresenter.profileCoordinator = self
        if let sheet = bonusesViewController.sheetPresentationController {
            sheet.detents = [.custom { _ in 355 }]
        }
        rootViewController?.present(bonusesViewController, animated: true)
    }

    func closeViewController() {
        rootViewController?.dismiss(animated: true)
    }

    func showTermsPolicyViewController() {
        let termsPolicyViewController = MainTabBarBuilder().makeTermsPolicyViewController()
        termsPolicyViewController.termsPolicyPresenter?.profileCoordinator = self
        rootViewController?.present(termsPolicyViewController, animated: true)
    }
}
