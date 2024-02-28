// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран авторизации
final class LoginViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont(name: "Verdana-Bold", size: 28)
        label.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.textColor = UIColor(red: 71 / 255, green: 92 / 255, blue: 102 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email Address"
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
        imageView.image = UIImage(named: "Message")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        addViews()
        addAnchors()
    }

    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0).cgColor,
            UIColor(red: 222 / 255, green: 238 / 255, blue: 225 / 255, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addViews() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailImageView)
        view.addSubview(titleLabel)
    }

    func addAnchors() {
        setupAnchorsEmailLabel()
        setupAnchorsEmailTextFiled()
        setupAnchorsEmailImageView()
        setupAnchorsTitleLabel()
    }

    func setupAnchorsTitleLabel() {
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 82).isActive = true
    }

    func setupAnchorsEmailLabel() {
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23).isActive = true
    }

    func setupAnchorsEmailTextFiled() {
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 13).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 340).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setupAnchorsEmailImageView() {
        emailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        emailImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailImageView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 29).isActive = true
    }
}
