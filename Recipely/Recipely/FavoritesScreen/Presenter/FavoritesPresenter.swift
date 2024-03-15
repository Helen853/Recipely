// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

/// Протокол FavoritesViewController
protocol FavoritesViewControllerProtocol: AnyObject {
    /// Обновление массива с избранным
    func uppdateFavorites(_ favorites: [Recipes])
    /// Скрытие заглущки и появление её если фавориты пустые
    func uppdateViewHidden()
}

/// Протокол FavoritesPresenter
protocol FavoritesPresenterProtocol: AnyObject {
    // Получение элементов из хранилища с избранными рецептами
    func returnFavorites()
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
    func returnFavorites() {
        if FavoritesStorageService.shared.favorites.count >= 1 {
            print(FavoritesStorageService.shared.favorites.count)
            view?.uppdateFavorites(FavoritesStorageService.shared.loadFavorites() ?? [Recipes(dto: RecipeDTO(
                image: "",
                label: "",
                totalTime: 0,
                calories: 0,
                uri: ""
            ))])
        }
    }
}
