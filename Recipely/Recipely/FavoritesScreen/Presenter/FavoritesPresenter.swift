// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол FavoritesViewController
protocol FavoritesViewControllerProtocol: AnyObject {
    /// Обновление массива с избранным
    func uppdateFavorites(_ favorites: [Recipes])
    /// Скрытие заглущки и появление её если фавориты пустые
    func uppdateViewHidden()
}

/// Протокол FavoritesPresenter
protocol FavoritesPresenterProtocol: AnyObject {
    /// Получение элементов из хранилища с избранными рецептами
    func returnFavourites(_ favorites: StorageFavorites)
}

/// Презентер экрана с фаворитами
final class FavoritesPresenter {
    // MARK: - Private Properties

    private weak var view: FavoritesViewControllerProtocol?
    private weak var favoritesCoordinator: FavoritesCoordinator?

    // MARK: - Initializers

    init(view: FavoritesViewControllerProtocol, coordinator: FavoritesCoordinator) {
        self.view = view
        favoritesCoordinator = coordinator
    }
}

/// FavoritesPresenter + FavoritesPresenterProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
    func pushDetaivFavoriteController() {
        debugPrint("pushDetailFavoritesViewController")
    }

    func returnFavourites(_ favorites: StorageFavorites) {
        if favorites.favoritesFood.count > 1 {
            view?.uppdateFavorites(favorites.favoritesFood)
        }
    }
}
