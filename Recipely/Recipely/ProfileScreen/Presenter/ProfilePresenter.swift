// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///Протокол для презентера экрана профиля
protocol ProfilePresenterProtocol {
    func changeName(text: String)
    func showTermsPolicy()
    func showBonuses()
    func showAlert()
}

/// Презентер экрана профиля
final class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    weak var profileCoordinator: ProfileCoordinator?
    init(view: ProfileViewProtocol) {
        self.view = view
    }
}

// MARK: - ProfilePresenter + ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    func changeName(text: String) {
        view?.changeLabel(updateName: text)
    }

    func showTermsPolicy() {
        profileCoordinator?.presentTemsPolicyController()
    }

    func showBonuses() {
        profileCoordinator?.presentBonusesController()
    }

    func showAlert() {
        view?.configureAlert()
    }
}
