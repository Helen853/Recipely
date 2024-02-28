// BonusesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентера экрана бонусов
protocol BonusesPresenterProtocol {
    func closeBonuses()
}

/// Презентер экрана бонусов
final class BonusesPresenter {
    weak var view: BonusesViewController?
    weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: BonusesViewController) {
        self.view = view
    }
}

// MARK: - BonusesPresenter + BonusesPresenterProtocol

extension BonusesPresenter: BonusesPresenterProtocol {
    func closeBonuses() {
        profileCoordinator?.closeBonuses()
    }
}
