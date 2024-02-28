// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для презентера экрана профиля
protocol ProfilePresenterProtocol {
    func changeName(text: String)
    func showTermsPolicy()
    func showBonuses()
    func showAlert()
}

/// Презентер экрана профиля
final class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    weak var profileCoordinator: ProfileCoordinator?
    init(view: ProfileViewProtocol) {
        self.view = view
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    /// Изменение имени пользователя профиле
    /// - Parametr: текст из поля ввода
    func changeName(text: String) {
        view?.changeLabel(updateName: text)
    }

    /// Передаем координатору чтобы показал условия политики
    func showTermsPolicy() {
        profileCoordinator?.presentTemsPolicyController()
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
