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
    /// Метод который выполнится при удачном запросе
    func succes()
    /// Метод который не выполнится при удачном запросе
    func failure(error: Error)
    /// Проверка стейта
    func checkViewState()
}

/// Протокол CategoryPresenter
protocol CategoryPresenterProtocol: AnyObject {
    /// Вернуться на RecipesScreen
    func goBackRecipesScreen()
    var coordinator: RecipesCoordinator? { get set }
    /// Возврат рецептов
    func returnRecipes(_ type: DishType)
    /// Сортировка
    func sortedRecipe(category: [Recipes])
    /// Смена значения кнопки калорий
    func buttonCaloriesChange(category: [Recipes])
    /// Смена значения кнопки калорий
    func buttonTimeChange(category: [Recipes])
    /// Смена стейта
    func changeState()
    /// Пережача модели на следующий экран
    func returnModel(model: Recipes)
    /// Изначальный стейт
    var state: ViewState<[Recipes]> { get set }
    /// Получение картинки
    func getImage(index: Int, handler: @escaping (Data) -> ())
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

    // MARK: - Public Properties

    var state: ViewState<[Recipes]> = .loading {
        didSet {
            view?.checkViewState()
        }
    }

    // MARK: - Private Properties

    private weak var view: CategoryViewControllerProtocol?
    weak var coordinator: RecipesCoordinator?
    private var sortedCalories = SortedCalories.non
    private var sortedTime = SortedTime.non
    private var recipes: [Recipes]?
    private let networkService: NetworkServiceProtocol?
    private var imageService = LoadImageSErvice()
    private lazy var proxy = ProxyImageService(service: imageService)

    // MARK: - Initializers

    init(view: CategoryViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func goBackRecipesScreen() {
        coordinator?.popRecipesViewController()
    }

    func getImage(index: Int, handler: @escaping (Data) -> ()) {
        guard let recipes = recipes else { return }
        guard let imageURL = URL(string: recipes[index].imageFoodName) else { return }
        proxy.loadImage(url: imageURL, complition: { data, _, _ in
            guard let data = data else { return }
            handler(data)
        })
    }

    func returnRecipes(_ type: DishType) {
        networkService?.getRecipe(dishType: type, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(recipes):
                    if recipes.isEmpty {
                        self.state = .noData
                        self.view?.checkViewState()
                    } else {
                        self.recipes = recipes
                        self.view?.succes()
                    }
                case let .failure(error):
                    self.state = .error
                    self.view?.checkViewState()
                    self.view?.failure(error: error)
                }
                self.view?.uppdateRecipes(self.recipes ?? [], type.rawValue)
            }
        })
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
