// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    func pushDetaivFavoriteController()
}
/// Презентер экрана с фаворитами
final class FavoritesPresenter {
    var view: UIViewController?
    var favoritesCoordinator: FavoritesCoordinator?

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
