// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Презентер ReciperPresenter
protocol ReciperPresenterProtocol: AnyObject {
    func openCell()
}

/// Презентер экрана рецептов
final class ReciperPresenter {
    private weak var view: UIViewController?
    private weak var coordinator: RecipesCoordinator?

    init(view: UIViewController, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

/// ReciperPresenter + ReciperPresenterProtocol
extension ReciperPresenter: ReciperPresenterProtocol {
    func openCell() {
        coordinator?.pushDetailViewController()
    }
}
