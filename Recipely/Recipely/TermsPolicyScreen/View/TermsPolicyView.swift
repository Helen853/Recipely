// TermsPolicyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Условия политики конфиденциальности
final class TermsPolicyView: UIView {
    // MARK: - Visual Components

    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let textLabel = UILabel()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureCloseButton()
        configureTitle()
        configureTextLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 30
    }

    private func configureTitle() {
        addSubview(titleLabel)
        textLabel.numberOfLines = 0
        titleLabel.font = .verdanaBold20
        titleLabel.text = AppConstants.termsUseTitle
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 169).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 45).isActive = true
    }

    private func configureTextLabel() {
        addSubview(textLabel)
        textLabel.font = .verdana14
        textLabel.text = AppConstants.termsText
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.widthAnchor.constraint(equalToConstant: 340).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 625).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 75).isActive = true
    }

    private func configureCloseButton() {
        addSubview(closeButton)
        closeButton.setImage(UIImage(named: AppConstants.closeImageName), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    }
}
