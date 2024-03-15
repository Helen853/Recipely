// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентора подробного экрана с рецептом
protocol RecipeDetailPresenterProtocol {
    /// Загрузка ячейки
    ///  -   Parametr: рецепт с данными
    func loadCell(recipe: Recipes?)
    /// Показать экран категорий рецептов
    func showCategory()
    /// Обновиление цвета кнопки
    func updateColorButton(title: String)
    /// Отправка текста рецепта в телеграм
    func shareRecipeText()
    /// Настройка кнопки "Сохранить в избранное"
    func setupSaveButton(title: String?)
    var stateDetails: ViewState<Detalis> { get }
    func changeState()
    //  var recipes: Recipes { get set }
    func getImage(index: Int, handler: @escaping (Data) -> ())
}

/// Презентор для экрана с подробным рецептом
final class RecipeDetailPresenter {
    weak var coordinator: RecipesCoordinator?
    private var state: SaveButtonState = .clear
    private var storage = RecipeDetail()
    private var details: [RecipeDetailProtocol]? = []
    private weak var view: RecipeDetailViewControllerProtocol?
    let networkService: NetworkServiceProtocol?
    var imageService = LoadImageSErvice()
    lazy var proxy = ProxyImageService(service: imageService)
    var stateDetails: ViewState<Detalis> = .loading {
        didSet {
            view?.checkViewState()
        }
    }

    // MARK: - Initializers

    init(view: RecipeDetailViewControllerProtocol, network: NetworkServiceProtocol) {
        self.view = view
        networkService = network
    }
}

// MARK: - Extension RecipeDetailPresenter + RecipeDetailPresenterProtocol

extension RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    func getImage(index: Int, handler: @escaping (Data) -> ()) {
        guard let details = details else { return }
        guard let stringUrl = (details[index] as? Image)?.imageName else { return }
        guard let imageURL = URL(string: stringUrl) else { return }
        proxy.loadImage(url: imageURL, complition: { data, _, _ in
            guard let data = data else { return }
            handler(data)
        })
    }

    func changeState() {
        view?.changeState()
    }

    /// Загрузка ячейки
    ///  -   Parametr: рецепт с данными
    func loadCell(recipe: Recipes?) {
        networkService?.getRecipesDetail(recipe?.uri ?? "", completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(details):
                    guard let detail = self?.storage.setupDetail(model: details) else { return }
                    self?.details = detail
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
    ///  -   Parametr:  наименование рецепта
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
    ///  -   Parametr:  наименование рецепта
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
