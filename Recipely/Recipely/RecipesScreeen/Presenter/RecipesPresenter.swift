// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ReciperPresenterProtocol: AnyObject {
    func openCell()
}

/// Презентер экрана рецептов
final class ReciperPresenter {
    private weak var view: UIViewController?
    var coordinator: RecipesCoordinator?

    init(view: UIViewController) {
        self.view = view
    }
}

/// ReciperPresenter + ReciperPresenterProtocol
extension ReciperPresenter: ReciperPresenterProtocol {
    func openCell() {
        coordinator?.pushDetailViewController()
    }
}
