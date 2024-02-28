// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер FavoritesPresenter
protocol FavoritesPresenterProtocol: AnyObject {
    func pushDetaivFavoriteController()
}

/// Презентер экрана с фаворитами
final class FavoritesPresenter {
    weak var view: UIViewController?
    weak var favoritesCoordinator: FavoritesCoordinator?

    init(view: UIViewController) {
        self.view = view
    }
}

/// FavoritesPresenter + FavoritesPresenterProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
    func pushDetaivFavoriteController() {
        debugPrint("pushDetailFavoritesViewController")
    }
}
