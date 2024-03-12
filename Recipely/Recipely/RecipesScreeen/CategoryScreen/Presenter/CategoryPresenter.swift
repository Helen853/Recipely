// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

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
    /// Изменение состояния
    func changeState()
}

/// Протокол CategoryPresenter
protocol CategoryPresenterProtocol: AnyObject {
    /// Вернуться на RecipesScreen
    func goBackRecipesScreen()
    var coordinator: RecipesCoordinator? { get set }
    /// Возврат рецептов
    func returnRecipes(_ type: CategoryCellType)

    func sortedRecipe(category: [Recipes])
    /// Смена значения кнопки калорий
    func buttonCaloriesChange(category: [Recipes])
    /// Смена значения кнопки калорий
    func buttonTimeChange(category: [Recipes])
    ///
    func changeState()
    func returnModel(model: Recipes)
}

/// Презентер экрана категорий
final class CategoryPresenter: CategoryPresenterProtocol {
    func returnModel(model: Recipes) {
        coordinator?.showRecipeDetailViewController(model: model)
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
        static let buttonPressedColor = "buttonPressed"
        static let buttonDefaultColor = "buttonDefault"
        static let stateImageOne = "CaloriesImage"
        static let stateImageTwo = "caloriesImageTwo"
        static let stateImageThree = "CaloriesImageThree"
    }

    // MARK: - Private Properties

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
        var sorted = category
        switch (sortedCalories, sortedTime) {
        case (.non, .non):
            view?.sortedRecip(recipe: sorted)
        case (.caloriesLow, _):
            if sortedTime == .timeLow {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.foodKkal == rhs.foodKkal {
                        return lhs.foodTime < rhs.foodTime
                    }
                    return lhs.foodTime < rhs.foodTime
                })
            } else if sortedTime == .timeHigh {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.foodKkal == rhs.foodKkal {
                        return lhs.foodTime > rhs.foodTime
                    }
                    return lhs.foodKkal < rhs.foodKkal
                })
            } else {
                sorted = category.sorted(by: { $0.foodKkal < $1.foodKkal })
            }
            view?.sortedRecip(recipe: sorted)
        case (.caloriesHigh, _):
            if sortedTime == .timeLow {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.foodKkal == rhs.foodKkal {
                        return lhs.foodTime > rhs.foodTime
                    }
                    return lhs.foodKkal > rhs.foodKkal
                })
            } else if sortedTime == .timeHigh {
                sorted = category.sorted(by: { lhs, rhs in
                    if lhs.foodKkal == rhs.foodKkal {
                        return lhs.foodTime < rhs.foodTime
                    }
                    return lhs.foodKkal > rhs.foodKkal
                })
            } else {
                sorted = category.sorted(by: { $0.foodKkal > $1.foodKkal })
            }
            view?.sortedRecip(recipe: sorted)
        case (_, .timeLow):
            sorted = category.sorted(by: { lhs, rhs in
                if lhs.foodTime == rhs.foodTime {
                    return lhs.foodKkal < rhs.foodKkal
                }
                return lhs.foodTime < rhs.foodTime
            })
            view?.sortedRecip(recipe: sorted)
        case (_, .timeHigh):
            sorted = category.sorted(by: { lhs, rhs in
                if lhs.foodTime == rhs.foodTime {
                    return lhs.foodKkal < rhs.foodKkal
                }
                return lhs.foodTime > rhs.foodTime
            })
            sorted = category.sorted(by: { $0.foodTime > $1.foodTime })
            view?.sortedRecip(recipe: sorted)
        }
    }

    func buttonTimeChange(category: [Recipes]) {
        switch sortedTime {
        case .non:
            sortedTime = .timeLow
            view?.buttonTimeState(color: Constants.buttonPressedColor, image: Constants.stateImageTwo)
            sortedRecipe(category: category)
        case .timeLow:
            sortedTime = .timeHigh
            view?.buttonTimeState(color: Constants.buttonPressedColor, image: Constants.stateImageThree)
            sortedRecipe(category: category)
        case .timeHigh:
            sortedTime = .non
            view?.buttonTimeState(color: Constants.buttonDefaultColor, image: Constants.stateImageOne)
            sortedRecipe(category: category)
        }
    }

    func buttonCaloriesChange(category: [Recipes]) {
        switch sortedCalories {
        case .non:
            sortedCalories = .caloriesLow
            view?.buttonCaloriesState(color: Constants.buttonPressedColor, image: Constants.stateImageTwo)
            sortedRecipe(category: category)
        case .caloriesLow:
            sortedCalories = .caloriesHigh
            view?.buttonCaloriesState(color: Constants.buttonPressedColor, image: Constants.stateImageThree)
            sortedRecipe(category: category)
        case .caloriesHigh:
            sortedCalories = .non
            view?.buttonCaloriesState(color: Constants.buttonDefaultColor, image: Constants.stateImageOne)
            sortedRecipe(category: category)
        }
    }

    func changeState() {
        view?.changeState()
    }
}
