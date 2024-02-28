// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор профиля
final class ProfileCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController

    init(rootViewController: UIViewController) {
        self.rootViewController = UINavigationController(rootViewController: rootViewController)
    }

    func presentTemsPolicyController() {
        print("Показываем экран с текстом")
    }

    func presentBonusesController() {
        let bonusesViewController = BonusesViewController()
        let bonusesPresenter = BonusesPresenter(view: bonusesViewController)
        bonusesViewController.bonusesPresenter = bonusesPresenter
        bonusesPresenter.profileCoordinator = self
        if let sheet = bonusesViewController.sheetPresentationController {
            sheet.detents = [.custom { _ in 355 }]
        }
        rootViewController.present(bonusesViewController, animated: true)
    }

    func closeBonuses() {
        rootViewController.dismiss(animated: true)
    }
}
