// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентора подробного экрана с рецептом
protocol RecipeDetailPresenterProtocol {
    /// Загрузка ячейки
    ///  -   Parametr: массив с данными
    func loadCell(model: [RecipeDetailProtocol])
    /// Показать экран категорий рецептов
    func showCategory()
    /// Обновиление цвета кнопки
    func updateColorButton(title: String)
    /// Отправка текста рецепта в телеграм
    func shareRecipeText()
}

/// Презентор для экрана с подробным рецептом
final class RecipeDetailPresenter {
    weak var coordinator: RecipesCoordinator?
    private var state: SaveButtonState = .clear
    private var storage = RecipeDetail()
    private weak var view: RecipeDetailViewControllerProtocol?

    // MARK: - Initializers

    init(view: RecipeDetailViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - Extension RecipeDetailPresenter + RecipeDetailPresenterProtocol

extension RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    /// Загрузка ячейки
    ///  -   Parametr: массив с данными
    func loadCell(model: [RecipeDetailProtocol]) {
        view?.loadTable(details: model)
    }

    /// Отправка текста рецепта в телеграм
    func shareRecipeText() {
        view?.shareRecipe(text: AppConstants.recipeText)
    }

    /// Обновиление цвета кнопки
    func updateColorButton(title: String) {
        // проверка состояния
        switch state {
        case .clear:
            state = .red
            // показать уведомление о добавлении в избранное
            view?.showAddFavoritesLabel()
            if var recipe = CategoryViewController.shared.recipes.first(where: { $0.foodName == title }) {
                recipe.isFavorites = true
                FavoritesService.shared.addFavorites(recipe)
            }
            // через 3 секунды скрыть уведомление и изменить кнопку
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.view?.removeLabel()
                self?.view?.updateSaveButton(state: self?.state ?? .clear)
            }
        case .red:
            state = .clear
            view?.updateSaveButton(state: state)
        }
    }

    /// Показать экран категорий рецептов
    func showCategory() {
        coordinator?.popDetailViewController()
    }
}
