// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ProfilePresenterProtocol {
    func changeName()
    func showTermsPolicy()
}

/// Презентер экрана профиля
final class ProfilePresenter {
    var view: UIViewController?
    var profileCoordinator: ProfileCoordinator?
    init(view: UIViewController) {
        self.view = view
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
