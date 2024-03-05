// TermsPolicyViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для экрана условий политики
protocol TermsPolicyViewControllerProtocol: AnyObject {}

/// Экран условий
final class TermsPolicyViewController: UIViewController {
    // MARK: - Visual Components

    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let textLabel = UILabel()

    // MARK: - Public Properties

    var termsPolicyPresenter: TermsPolicyPresenter?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCloseButton()
        configureTitle()
        configureTextLabel()
    }

    // MARK: - Private Methods

    private func configureView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
    }

    private func configureTitle() {
        view.addSubview(titleLabel)
        textLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = AppConstants.termsUseTitle
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 169).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
    }

    private func configureTextLabel() {
        view.addSubview(textLabel)
        textLabel.font = UIFont(name: AppConstants.fontVerdana, size: 14)
        textLabel.text = AppConstants.termsText
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.widthAnchor.constraint(equalToConstant: 340).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 625).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
    }

    private func configureCloseButton() {
        view.addSubview(closeButton)
        closeButton.setImage(UIImage(named: AppConstants.closeImageName), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.addTarget(self, action: #selector(onCloseButtonTap), for: .touchUpInside)
    }

    @objc private func onCloseButtonTap() {
        termsPolicyPresenter?.closeTermsPolicy()
    }
}

extension TermsPolicyViewController: TermsPolicyViewControllerProtocol {}
