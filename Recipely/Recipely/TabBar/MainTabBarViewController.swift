// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// TabBar
final class MainTabBarController: UITabBarController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        view.backgroundColor = .white
    }

    // MARK: - Private Methods

    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = #colorLiteral(red: 0.5131713152, green: 0.7742882967, blue: 0.7948206067, alpha: 1)
        tabBar.unselectedItemTintColor = .lightGray
    }
}
