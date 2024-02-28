// LoginPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func setValidationStatusEmail(_ colorText: UIColor, _ colorBorder: UIColor, _ isValidation: Bool)
    func setValidationStatusPassword(_ colorText: UIColor, _ colorBorder: UIColor, _ isValidation: Bool)
    func setloginButtonPressed(_ nameOfButtonImage: String, _ titleButton: String)
    func showErrorSplashOn()
    func showErrorSplashOff()
    func showPassword(_ eyeImageView: UIImage, _ isSecurity: Bool)
}

protocol LoginPresenterProtocol: AnyObject {
    func setColorEmail(_ email: String)
    func setColorPassword(_ password: String, _ email: String)
    func setSecurity(_ isSecurity: Bool)
}

/// Презентер экрана авторизации
final class LoginPresenter: LoginPresenterProtocol {
    // MARK: - Constants

    private enum Constants {
        static let domenEmail = "@mail.ru"
        static let errorColor = "errorColor"
        static let defaultTextColor = "defaultTextColor"
        static let defaultBorderTextFieldColor = "defaultBorderTextFieldColor"
        static let eyeImageName = "eye.fill"
        static let eyeSlashImageName = "eye.slash.fill"
        static let spinerIamgename = "spiner"
        static let titleButtonText = "Login"
        static let dispatchQueueTime = 3.0
        static let passwordCount = 5
    }

    // MARK: - Public Properties

    weak var loginCoordinator: LoginCoordinator?
    weak var view: LoginViewControllerProtocol?

    // MARK: - Initializers

    required init(view: LoginViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func setColorEmail(_ email: String) {
        if email.contains(Constants.domenEmail) {
            view?.setValidationStatusEmail(
                UIColor(named: Constants.defaultTextColor) ?? UIColor(),
                UIColor(named: Constants.defaultBorderTextFieldColor) ?? UIColor(),
                true
            )
        } else {
            view?.setValidationStatusEmail(
                UIColor(named: Constants.errorColor) ?? UIColor(),
                UIColor(named: Constants.errorColor) ?? UIColor(),
                false
            )
        }
    }

    func setColorPassword(_ password: String, _ email: String) {
        if password.count > Constants.passwordCount, email.contains(Constants.domenEmail) {
            view?.setValidationStatusPassword(
                UIColor(named: Constants.defaultTextColor) ?? UIColor(),
                UIColor(named: Constants.defaultBorderTextFieldColor) ?? UIColor(),
                true
            )
            view?.setloginButtonPressed(Constants.spinerIamgename, "")
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.dispatchQueueTime) { [weak self] in
                self?.view?.setloginButtonPressed("", Constants.titleButtonText)
            }
        } else {
            view?.showErrorSplashOn()
            view?.setValidationStatusPassword(
                UIColor(named: Constants.errorColor) ?? UIColor(),
                UIColor(named: Constants.errorColor) ?? UIColor(),
                false
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.dispatchQueueTime) { [weak self] in
                self?.view?.showErrorSplashOff()
            }
        }
    }

    func setSecurity(_ isSecurity: Bool) {
        if isSecurity == true {
            view?.showPassword(UIImage(systemName: Constants.eyeImageName) ?? UIImage(), false)
        } else if isSecurity == false {
            view?.showPassword(UIImage(systemName: Constants.eyeSlashImageName) ?? UIImage(), true)
        }
    }
}
