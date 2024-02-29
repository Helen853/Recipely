// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для RecipesPresenter
protocol ReciperPresenterProtocol: AnyObject {
    // открываем ячейку
    func openCell(type: CategoryCellType)
}

/// Презентер экрана рецептов
final class RecipesPresenter {
    private weak var view: UIViewController?
    private weak var coordinator: RecipesCoordinator?

    init(view: UIViewController, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

/// ReciperPresenter + ReciperPresenterProtocol
extension RecipesPresenter: ReciperPresenterProtocol {
    func openCell(type: CategoryCellType) {
        coordinator?.pushDetailViewController(type: type)
    }
}
