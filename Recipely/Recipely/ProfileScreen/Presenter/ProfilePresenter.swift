// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для презентера экрана профиля
protocol ProfilePresenterProtocol {
    func changeName(text: String)
    func showBonuses()
    func showAlert()
    func showTermsPolicy()
}

/// Презентер экрана профиля
final class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private weak var profileCoordinator: ProfileCoordinator?
    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    func showTermsPolicy() {
        profileCoordinator?.showTermsPolicyViewController()
    }

    /// Изменение имени пользователя профиле
    /// - Parametr: текст из поля ввода
    func changeName(text: String) {
        view?.changeLabel(updateName: text)
    }

    /// Передаем координатору чтобы показал шторку с бонусами
    func showBonuses() {
        profileCoordinator?.presentBonusesController()
    }

    /// Показываем алерт
    func showAlert() {
        view?.configureAlert()
    }
}
