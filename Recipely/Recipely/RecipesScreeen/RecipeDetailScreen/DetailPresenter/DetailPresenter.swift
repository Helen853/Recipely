// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентора подробного экрана с рецептом
protocol RecipeDetailPresenterProtocol {
    /// Загрузка ячейки
    func loadCell(recipe: Recipes?)
    /// Показать экран категорий рецептов
    func showCategory()
    /// Обновиление цвета кнопки
    func updateColorButton(title: String)
    /// Отправка текста рецепта в телеграм
    func shareRecipeText()
    /// Настройка кнопки "Сохранить в избранное"
    func setupSaveButton(title: String?)
    /// Смена стейта
    func changeState()
}

/// Презентор для экрана с подробным рецептом
final class RecipeDetailPresenter {
    // MARK: - Private Methods

    var stateDetails: ViewState<Detalis> = .loading {
        didSet {
            view?.checkViewState()
        }
    }

    // MARK: - Private Methods

    weak var coordinator: RecipesCoordinator?
    private var state: SaveButtonState = .clear
    private var storage = RecipeDetail()
    private weak var view: RecipeDetailViewControllerProtocol?
    private let networkService: NetworkServiceProtocol?

    // MARK: - Initializers

    init(view: RecipeDetailViewControllerProtocol, network: NetworkServiceProtocol) {
        self.view = view
        networkService = network
    }
}

// MARK: - Extension RecipeDetailPresenter + RecipeDetailPresenterProtocol

extension RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    func changeState() {
        view?.changeState()
    }

    /// Загрузка ячейки
    func loadCell(recipe: Recipes?) {
        networkService?.getRecipesDetail(recipe?.uri ?? "", completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(details):
                    guard let detail = self?.storage.setupDetail(model: details) else { return }
                    if detail.isEmpty {
                        self?.stateDetails = .noData
                        self?.view?.checkViewState()
                    } else {
                        self?.view?.updateRecipe(recipe: recipe)
                        self?.view?.loadTable(details: detail)
                        self?.view?.succes()
                    }
                case let .failure(error):
                    self?.stateDetails = .error
                    self?.view?.checkViewState()
                    self?.view?.failure(error: error)
                }
            }
        })
    }

    /// Настройка кнопки "Сохранить в избранное"
    func setupSaveButton(title: String?) {
        // проверяем содержится ли рецепт с данными наименованием в избранном
        if FavoritesStorageService.shared.favorites.contains(where: { $0.foodName == title }) {
            state = .red
            view?.updateSaveButton(state: state)
        } else {
            state = .clear
            view?.updateSaveButton(state: state)
        }
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
            if let recipe = CategoryViewController.shared.recipes.first(where: { $0.foodName == title }) {
                FavoritesStorageService.shared.addFavorites(recipe)
            }
            // через 3 секунды скрыть уведомление и изменить кнопку
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.view?.removeLabel()
                self?.view?.updateSaveButton(state: self?.state ?? .clear)
            }
        case .red:
            state = .clear
            // обновить кнопку в другой цвет
            view?.updateSaveButton(state: state)

            // находим индекс элемента по названию
            guard let indexOfRecipe = FavoritesStorageService.shared.favorites
                .firstIndex(where: { $0.foodName == title })
            else { return }
            // удаляем элемент из избранного
            FavoritesStorageService.shared.removeFavorites(Int(indexOfRecipe))
        }
    }

    /// Показать экран категорий рецептов
    func showCategory() {
        coordinator?.popDetailViewController()
    }
}
