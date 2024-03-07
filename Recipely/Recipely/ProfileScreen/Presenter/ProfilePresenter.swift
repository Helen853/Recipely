// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для презентера экрана профиля
protocol ProfilePresenterProtocol {
    func changeName(text: String)
    func showBonuses()
    func showAlert()
    func showTermsPolicy()
    func removeTermsPolicy()
    func addVisualEffect()
    var user: User { get set }
}

/// Презентер экрана профиля
final class ProfilePresenter {
    // MARK: - Constants

    private enum Constants {
        static let removeTermsPolicyTime = 0.7
    }

    private weak var view: ProfileViewProtocol?
    private weak var profileCoordinator: ProfileCoordinator?
    var user = UserStateWrapper.shared.loadUser()
    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    func addVisualEffect() {
        view?.animateTransition(state: .started, duration: 1)
    }

    func removeTermsPolicy() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.removeTermsPolicyTime) { [weak self] in
            self?.view?.removeTerms()
            self?.view?.removeVisualEffect()
        }
    }

    func showTermsPolicy() {
        view?.setupTermsPolicy()
    }

    /// Изменение имени пользователя профиле
    /// - Parametr: текст из поля ввода
    func changeName(text: String) {
        UserStateWrapper.shared.updateNickname(text)
        user = UserStateWrapper.shared.loadUser()
        print("Posle updateNickname \(user.email) \(user.password)")
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
