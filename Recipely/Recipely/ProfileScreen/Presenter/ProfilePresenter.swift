// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ProfilePresenterProtocol {
    func changeName()
    func showTermsPolicy()
}

protocol ProfileViewProtocol: AnyObject {
    func configureAlert()
}

/// Презентер экрана профиля
final class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var profileCoordinator: ProfileCoordinator?
    init(view: ProfileViewProtocol) {
        self.view = view
    }

    func showAlert() {
        view?.configureAlert()
    }
}

/// ProfilePresenter + ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    func changeName() {
        print("функция по замене имени")
    }

    func showTermsPolicy() {
        profileCoordinator?.presentTemsPolicyController()
    }
}
