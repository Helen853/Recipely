// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер FavoritesPresenter
protocol FavoritesPresenterProtocol: AnyObject {
    func pushDetaivFavoriteController()
}

/// Презентер экрана с фаворитами
final class FavoritesPresenter {
    private weak var view: UIViewController?
    private weak var favoritesCoordinator: FavoritesCoordinator?

    init(view: UIViewController, coordinator: FavoritesCoordinator) {
        self.view = view
        favoritesCoordinator = coordinator
    }
}

/// FavoritesPresenter + FavoritesPresenterProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
    func pushDetaivFavoriteController() {
        debugPrint("pushDetailFavoritesViewController")
    }
}
