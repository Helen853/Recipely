// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сортировка по калорием
enum SortedCalories {
    /// Обычное состояние
    case non
    /// Состояние в меньшую сторону
    case caloriesLow
    /// Состояние в большое сторону
    case caloriesHigh
}

/// Сортировка по времени
enum SortedTime {
    /// Обчное состояние
    case non
    /// Состояние в меньшую сторону
    case timeLow
    /// Состояние в большую сторону
    case timeHigh
}

/// Протокол CategoryViewControllerProtocol
protocol CategoryViewControllerProtocol: AnyObject {
    /// Функция замены тайтла страницы и добавление элементов из хранилища
    func uppdateRecipes(_ recipes: [Recipes], _ title: String)
    ///  Установка отсортированных рецептов
    func sortedRecip(recipe: [Recipes])
    /// Установка занчения кнопки калорий
    func buttonCaloriesState(color: String, image: String)
    /// Установка занчения кнопки времени
    func buttonTimeState(color: String, image: String)
}

/// Протокол CategoryPresenter
protocol CategoryPresenterProtocol: AnyObject {
    /// Вернуться на RecipesScreen
    func goBackRecipesScreen()
    var coordinator: RecipesCoordinator? { get set }
    /// Возврат рецептов
    func returnRecipes(_ type: CategoryCellType)
    /// Переход на экран подробного рецепта
    func showRecipeDetail()
    /// Сортировка рецептов
    func sortedRecipe(category: [Recipes])
    /// Смена значения кнопки калорий
    func buttonCaloriesChange(category: [Recipes])
    /// Смена значения кнопки калорий
    func buttonTimeChange(category: [Recipes])
}

/// Презентер экрана категорий
final class CategoryPresenter: CategoryPresenterProtocol {
    func showRecipeDetail() {
        coordinator?.showRecipeDetailViewController()
    }

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

    private var state: SortingState = .none
    private weak var view: CategoryViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?
    private var sortedCalories = SortedCalories.non
    private var sortedTime = SortedTime.non
    private var recipes: [Recipes]?

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

    func sortedRecipe(category: [Recipes]) {
        let sorted: [Recipes]
        switch (sortedCalories, sortedTime) {
        case (.non, .non):
            sorted = category
        case (.caloriesLow, _):
            sorted = category.sorted(by: { $0.foodKkal < $1.foodKkal })
        case (.caloriesHigh, _):
            sorted = category.sorted(by: { $0.foodKkal > $1.foodKkal })
        case (_, .timeLow):
            sorted = category.sorted(by: { $0.foodTime < $1.foodTime })
        case (_, .timeHigh):
            sorted = category.sorted(by: { $0.foodTime > $1.foodTime })
        }
        view?.sortedRecip(recipe: sorted)
    }

    func buttonTimeChange(category: [Recipes]) {
        if sortedTime == .non {
            sortedTime = .timeLow
            view?.buttonTimeState(color: "buttonPressed", image: "caloriesImageTwo")
            sortedRecipe(category: category)
        } else if sortedTime == .timeLow {
            view?.buttonTimeState(color: "buttonPressed", image: "CaloriesImageThree")
            sortedTime = .timeHigh
            sortedRecipe(category: category)
        } else if sortedTime == .timeHigh {
            sortedTime = .non
            view?.buttonTimeState(color: "buttonDefault", image: "CaloriesImage")
            sortedRecipe(category: category)
        }
    }

    func buttonCaloriesChange(category: [Recipes]) {
        if sortedCalories == .non {
            sortedCalories = .caloriesLow
            view?.buttonCaloriesState(color: "buttonPressed", image: "caloriesImageTwo")
            sortedRecipe(category: category)
        } else if sortedCalories == .caloriesLow {
            sortedCalories = .caloriesHigh
            view?.buttonCaloriesState(color: "buttonPressed", image: "CaloriesImageThree")
            sortedRecipe(category: category)
        } else if sortedCalories == .caloriesHigh {
            sortedCalories = .non
            view?.buttonCaloriesState(color: "buttonDefault", image: "CaloriesImage")
            sortedRecipe(category: category)
        }
    }
}
