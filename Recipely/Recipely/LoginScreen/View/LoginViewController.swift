// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран авторизации
final class LoginViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdanaBold = "Verdana-Bold"
        static let errorColorName = "errorColor"
        static let titleLabelText = "Login"
        static let emailLabelText = "Email Address"
        static let emailTextFieldPlaceholder = "Enter Email Address"
        static let emailImageViewName = "Message"
        static let errorEmailLabelText = "Incorrect format"
        static let passwordLabelText = "Password"
        static let passwordTextFieldPlaceholder = "Enter Password"
        static let passwordImageViewName = "Password"
        static let errorPasswordLabelText = "You entered the wrong password"
        static let eyePasswordButtonName = "eye.slash.fill"
        static let loginButtonTitle = "Login"
        static let splashTitleLabelText = "Please check the accuracy of the entered credentials."
        static let keyboardOffset = 10
        static let durationLoading = 0.3
        static let heightMultiplayer = 0.85
        static let addDoneButtonToKeyboard = "Ok"
        static let durationErrorLabelShow = 0.4
        static let coordinateY = -180
    }

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabelText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 28)
        label.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emailLabelText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 18)
        label.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.emailTextFieldPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 208 / 255, green: 212 / 255, blue: 218 / 255, alpha: 1.0).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    private let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.emailImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let errorEmailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.errorEmailLabelText
        label.isHidden = true
        label.textColor = UIColor(named: Constants.errorColorName)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.passwordLabelText
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 18)
        label.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.passwordTextFieldPlaceholder
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 208 / 255, green: 212 / 255, blue: 218 / 255, alpha: 1.0).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    private let passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.passwordImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let errorPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.errorPasswordLabelText
        label.isHidden = true
        label.textColor = UIColor(named: Constants.errorColorName)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var eyePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.eyePasswordButtonName), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPasswordTextField), for: .touchUpInside)
        return button
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(Constants.loginButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeColorEmailLabel), for: .touchUpInside)
        return button
    }()

    private let erorrView: UIView = {
        let splash = UIView()
        splash.layer.cornerRadius = 12
        splash.backgroundColor = UIColor(named: Constants.errorColorName)
        return splash
    }()

    private let errorTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        label.text = Constants.splashTitleLabelText
        return label
    }()

    // MARK: - Public Properties

    var loginPresenter: LoginPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        addViews()
        addAnchors()
        setupTextFields()
        observrbleKeyboard()
    }

    // MARK: - Private Methods

    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0).cgColor,
            UIColor(red: 222 / 255, green: 238 / 255, blue: 225 / 255, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func addViews() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailImageView)
        view.addSubview(titleLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordImageView)
        view.addSubview(loginButton)
        view.addSubview(errorEmailLabel)
        view.addSubview(errorPasswordLabel)
        view.addSubview(eyePasswordButton)
        view.addSubview(erorrView)
        erorrView.addSubview(errorTitleLabel)
    }

    private func addAnchors() {
        setupAnchorsEmailLabel()
        setupAnchorsEmailTextFiled()
        setupAnchorsEmailImageView()
        setupAnchorsTitleLabel()
        setupAnchorsPasswordLabel()
        setupAnchorsPasswordTextField()
        setupAnchorsPasswirdImageView()
        setupAnchorsLoginButton()
        setupAnchorsErrorEmailLabel()
        setupAnchorsErrorPasswordLabel()
        setupAnchorsEyePasswordButton()
        makeSplashAnchor()
        makeSplashTitleAnchor()
    }

    private func setupAnchorsTitleLabel() {
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82).isActive = true
    }

    private func setupAnchorsEmailLabel() {
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23).isActive = true
    }

    private func setupAnchorsEmailTextFiled() {
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 13).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 340).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupAnchorsEmailImageView() {
        emailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        emailImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailImageView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 29).isActive = true
    }

    private func setupAnchorsPasswordLabel() {
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
    }

    private func setupAnchorsPasswordTextField() {
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 13).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 340).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupAnchorsPasswirdImageView() {
        passwordImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        passwordImageView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 26).isActive = true
    }

    private func setupAnchorsLoginButton() {
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setupAnchorsErrorEmailLabel() {
        errorEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        errorEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3).isActive = true
    }

    private func setupAnchorsErrorPasswordLabel() {
        errorPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        errorPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3).isActive = true
    }

    private func setupAnchorsEyePasswordButton() {
        eyePasswordButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 28).isActive = true
        eyePasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }

    private func makeSplashAnchor() {
        erorrView.translatesAutoresizingMaskIntoConstraints = false
        erorrView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        erorrView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        erorrView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        erorrView.heightAnchor.constraint(equalToConstant: 87).isActive = true
    }

    private func makeSplashTitleAnchor() {
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorTitleLabel.centerXAnchor.constraint(equalTo: erorrView.centerXAnchor).isActive = true
        errorTitleLabel.centerYAnchor.constraint(equalTo: erorrView.centerYAnchor).isActive = true
        errorTitleLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        errorTitleLabel.leadingAnchor.constraint(equalTo: erorrView.leadingAnchor, constant: 15).isActive = true
        errorTitleLabel.trailingAnchor.constraint(equalTo: erorrView.trailingAnchor, constant: -34).isActive = true
    }

    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func observrbleKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }

        let distanceFromKeyboard = keyboardFrame.height + CGFloat(Constants.keyboardOffset)
        loginButton.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: Constants.durationLoading) {
            self.loginButton.frame.origin.y = self.view.frame.height - distanceFromKeyboard - self.loginButton.frame
                .height
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        UIView.animate(withDuration: Constants.durationLoading) {
            self.loginButton.frame.origin.y = UIScreen.main.bounds.height * Constants.heightMultiplayer
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func changeColorEmailLabel() {
        loginPresenter?.setColorPassword(passwordTextField.text ?? "", emailTextField.text ?? "")
    }

    @objc private func showPasswordTextField() {
        loginPresenter?.setSecurity(passwordTextField.isSecureTextEntry)
    }
}

/// LoginViewController + UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        addDoneButtonToKeyboard(textField)
    }

    private func addDoneButtonToKeyboard(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(
            title: Constants.addDoneButtonToKeyboard,
            style: .plain,
            target: self,
            action: #selector(okButtonTapped)
        )
        toolbar.items = [flexibleSpace, okButton]
        textField.inputAccessoryView = toolbar
    }

    @objc private func okButtonTapped() {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        loginPresenter?.setColorEmail(emailTextField.text ?? "")
    }
}

/// LoginViewController + LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
    func showPassword(_ eyeImageView: String, _ isSecurity: Bool) {
        eyePasswordButton.setImage(UIImage(systemName: eyeImageView), for: .normal)
        passwordTextField.isSecureTextEntry = isSecurity
    }

    func showErrorSplashOn() {
        UIView.animate(withDuration: Constants.durationErrorLabelShow) {
            self.erorrView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: CGFloat(Constants.coordinateY))
        }
    }

    func showErrorSplashOff() {
        UIView.animate(withDuration: Constants.durationErrorLabelShow) {
            self.erorrView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
        }
    }

    func setloginButtonPressed(_ nameOfButtonImage: String, _ titleButton: String) {
        loginButton.setImage(UIImage(named: nameOfButtonImage), for: .normal)
        loginButton.setTitle(titleButton, for: .normal)
        loginButton.imageView?.rotate()
    }

    func setValidationStatusPassword(_ colorText: String, _ colorBorder: String, _ isValidation: Bool) {
        passwordLabel.textColor = UIColor(named: colorText)
        passwordTextField.layer.borderColor = UIColor(named: colorBorder)?.cgColor
        errorPasswordLabel.isHidden = isValidation
    }

    func setValidationStatusEmail(_ colorText: String, _ colorBorder: String, _ isValidation: Bool) {
        emailLabel.textColor = UIColor(named: colorText)
        emailTextField.layer.borderColor = UIColor(named: colorBorder)?.cgColor
        errorEmailLabel.isHidden = isValidation
    }
}
