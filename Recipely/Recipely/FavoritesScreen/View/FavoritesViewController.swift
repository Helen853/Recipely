// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с избранным
final class FavoritesViewController: UIViewController {
    var fvoritesPresenter: FavoritesPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
}
