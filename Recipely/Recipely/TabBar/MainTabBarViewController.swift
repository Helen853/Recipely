// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный таббар
final class MainTabBarController: UITabBarController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        setBackgroundColorView()
    }

    // MARK: - Private Methods

    private func setBackgroundColorView() {
        view.backgroundColor = .white
    }

    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .turquoise
        tabBar.unselectedItemTintColor = .lightGray
    }
}
