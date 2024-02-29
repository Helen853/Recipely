// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол CategoryViewControllerProtocol
protocol CategoryViewControllerProtocol: AnyObject {
    /// Функция замены тайтла страницы и добавление элементов из хранилища
    func uppdateRecipes(_ recipes: [Recipes], _ title: String)
}

/// Протокол CategoryPresenter
protocol CategoryPresenterProtocol: AnyObject {
    /// Вернуться на RecipesScreen
    func goBackRecipesScreen()
    var coordinator: RecipesCoordinator? { get set }
    /// Получение рецептов
    func returnRecipes(_ type: CategoryCellType)
}

/// Презентер экрана категорий
final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Constants

    private enum Constants {
        static let fish = "Fish"
        static let salad = "Salad"
        static let soup = "Soup"
        static let chiken = "Chiken"
        static let meat = "Meat"
        static let sideDish = "Side Dish"
        static let drinks = "Drinks"
        static let pancake = "Pancake"
        static let desserts = "Desserts"
    }

    // MARK: - Private Properties

    private weak var view: CategoryViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?

    // MARK: - Initializers

    init(view: CategoryViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func goBackRecipesScreen() {
        coordinator?.popRecipesViewController()
    }

    func returnRecipes(_ type: CategoryCellType) {
        let storage = StorageRecipes()
        switch type {
        case .fish:
            view?.uppdateRecipes(storage.fish, Constants.fish)
        case .salad:
            view?.uppdateRecipes(storage.chicken, Constants.salad)
        case .soup:
            view?.uppdateRecipes(storage.chicken, Constants.soup)
        case .chicken:
            view?.uppdateRecipes(storage.chicken, Constants.chiken)
        case .meat:
            view?.uppdateRecipes(storage.chicken, Constants.meat)
        case .sideDish:
            view?.uppdateRecipes(storage.chicken, Constants.sideDish)
        case .drinks:
            view?.uppdateRecipes(storage.chicken, Constants.drinks)
        case .pancake:
            view?.uppdateRecipes(storage.chicken, Constants.pancake)
        case .desserts:
            view?.uppdateRecipes(storage.chicken, Constants.desserts)
        }
    }
}
