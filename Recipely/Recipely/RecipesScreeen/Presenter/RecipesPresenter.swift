// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для RecipesPresenter
protocol ReciperPresenterProtocol: AnyObject {
    /// Открытие ячейки
    /// -   Parametr: тип ячейки
    func openCell(type: CategoryType)
    /// Загрузка  коллекции
    ///  -   Parametr: массив с данными
    func loadCell(model: [Category])
}

/// Презентер экрана рецептов
final class RecipesPresenter {
    private weak var view: RecipesViewControllerProtocol?
    private weak var coordinator: RecipesCoordinator?
    init(view: RecipesViewControllerProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

/// ReciperPresenter + ReciperPresenterProtocol
extension RecipesPresenter: ReciperPresenterProtocol {
    /// Загрузка  коллекции
    ///  -   Parametr: массив с данными
    func loadCell(model: [Category]) {
        view?.loadCollection(categories: model)
    }

    /// Открытие ячейку
    /// -   Parametr: тип ячейки
    func openCell(type: CategoryType) {
        coordinator?.pushDetailViewController(type: type)
    }
}
