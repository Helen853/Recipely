// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для презентера экрана профиля
protocol ProfilePresenterProtocol {
    /// Смена имени
    func changeName(text: String)
    /// Показ экрана бонусов
    func showBonuses()
    /// Показ алерта с заменом имени
    func showAlert()
    /// Показ экрана showTermsPolicy
    func showTermsPolicy()
    /// Скрытие экрана showTermsPolicy
    func removeTermsPolicy()
    /// Наложение эффектов
    func addVisualEffect()
    /// Смена аватара
    func changeAvatar()
    /// Сохранение аватара
    func saveAvatar(image: Data)
    /// Получение аватара
    func getAvatarData() -> Data?
    /// Модель юзера
    var user: User { get set }
}

/// Презентер экрана профиля
final class ProfilePresenter {
    // MARK: - Constants

    private enum Constants {
        static let removeTermsPolicyTime = 0.7
    }

    // MARK: - Uplic Properties

    var user = UserOriginator.shared.loadUser()

    // MARK: - Private Properties

    private weak var view: ProfileViewProtocol?
    private weak var profileCoordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: ProfileViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    /// Получение аватара
    func getAvatarData() -> Data? {
        let data = UserOriginator.shared.getImageDataFromUserDefaults()
        return data
    }

    /// Сохранение аватара
    func saveAvatar(image: Data) {
        UserOriginator.shared.saveImageInUserDefaults(data: image)
    }

    /// Смена аватара
    func changeAvatar() {
        view?.showGallery()
    }

    /// Наложение эффектов
    func addVisualEffect() {
        view?.animateTransition(state: .started, duration: 1)
    }

    /// Скрытие экрана showTermsPolicy
    func removeTermsPolicy() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.removeTermsPolicyTime) { [weak self] in
            self?.view?.removeTerms()
            self?.view?.removeVisualEffect()
        }
    }

    /// Показ экрана showTermsPolicy
    func showTermsPolicy() {
        view?.setupTermsPolicy()
    }

    /// Изменение имени пользователя профиле
    /// - Parametr: текст из поля ввода
    func changeName(text: String) {
        UserOriginator.shared.updateNickname(text)
        user = UserOriginator.shared.loadUser()
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
