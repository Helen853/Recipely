// LoginPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол LoginViewController
protocol LoginViewControllerProtocol: AnyObject {
    /// Проверка валидации почты
    func setValidationStatusEmail(_ colorText: String, _ colorBorder: String, _ isValidation: Bool)
    /// Проверка валидации пароля
    func setValidationStatusPassword(_ colorText: String, _ colorBorder: String, _ isValidation: Bool)
    /// Установка кружка загрузки на кнопке после нажатия
    func setloginButtonPressed(_ nameOfButtonImage: String, _ titleButton: String)
    /// Показать экран предупрежденияя
    func showErrorSplashOn()
    /// Скрыть экран предупреждения
    func showErrorSplashOff()
    /// Показать/скрыть пароль
    func showPassword(_ eyeImageView: String, _ isSecurity: Bool)
}

/// Протокол LoginPresenter
protocol LoginPresenterProtocol: AnyObject {
    /// Установка цвета emailView
    func setColorEmail(_ email: String)
    /// Установка цвета passwordView
    func setColorPassword(_ password: String, _ email: String)
    /// Установка секретности
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
        static let defaultSurname = "Surname Name"
    }

    // MARK: - Public Properties

    private weak var loginCoordinator: LoginCoordinator?
    private weak var view: LoginViewControllerProtocol?

    // MARK: - Initializers

    required init(view: LoginViewControllerProtocol, coordinator: LoginCoordinator) {
        self.view = view
        loginCoordinator = coordinator
    }

    // MARK: - Public Methods

    func setColorEmail(_ email: String) {
        if email.contains(Constants.domenEmail) {
            view?.setValidationStatusEmail(
                Constants.defaultTextColor,
                Constants.defaultBorderTextFieldColor,
                true
            )
        } else {
            view?.setValidationStatusEmail(
                Constants.errorColor,
                Constants.errorColor,
                false
            )
        }
    }

    func setColorPassword(_ password: String, _ email: String) {
        if password.count > Constants.passwordCount, email.contains(Constants.domenEmail) {
            if UserOriginator.shared.loadFromUserDefaults() == nil {
                UserOriginator.shared.updateUser(User(
                    email: email,
                    password: password,
                    surname: Constants.defaultSurname
                ))
            }
            let userEmail = UserOriginator.shared.loadFromUserDefaults()?.email
            let userPassword = UserOriginator.shared.loadFromUserDefaults()?.password
            if userEmail == email, userPassword == password {
                view?.setValidationStatusPassword(
                    Constants.defaultTextColor,
                    Constants.defaultBorderTextFieldColor,
                    true
                )
                /// Переход на следующий экран
                view?.setloginButtonPressed(Constants.spinerIamgename, "")

                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.dispatchQueueTime) { [weak self] in
                    self?.view?.setloginButtonPressed("", Constants.titleButtonText)
                    self?.loginCoordinator?.goToTabBarScreen()
                }
            } else {
                view?.showErrorSplashOn()
                view?.setValidationStatusPassword(
                    Constants.errorColor,
                    Constants.errorColor,
                    false
                )
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.dispatchQueueTime) { [weak self] in
                    self?.view?.showErrorSplashOff()
                }
            }
        } else {
            view?.showErrorSplashOn()
            view?.setValidationStatusPassword(
                Constants.errorColor,
                Constants.errorColor,
                false
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.dispatchQueueTime) { [weak self] in
                self?.view?.showErrorSplashOff()
            }
        }
    }

    func setSecurity(_ isSecurity: Bool) {
        let imageName = isSecurity ? Constants.eyeImageName : Constants.eyeSlashImageName
        let shouldHidePassword = isSecurity ? false : true
        view?.showPassword(imageName, shouldHidePassword)
    }
}
