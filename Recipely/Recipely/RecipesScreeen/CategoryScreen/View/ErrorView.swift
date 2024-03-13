// ErrorView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Плашка с ошибкой
final class ErrorView: UIView {
    // MARK: - Visual Components

    private let backgroundView = UIView()
    private let imageBackgroundView = UIView()
    private let titleLabel = UILabel()
    private let reloadButton = UIButton()
    private let centrImageView = UIImageView()
    private let reloadImageView = UIImageView()
    private let reloadLabel = UILabel()

    // MARK: - Initializers

    init(frame: CGRect, imageName: String, title: String) {
        super.init(frame: .zero)
        reloadImageView.image = UIImage(named: imageName)
        titleLabel.text = title
        configureView()
        configureimageBackgroundView()
        configureCentrImageView()
        configureLabel()
        configureButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configureimageBackgroundView()
        configureCentrImageView()
        configureLabel()
        configureButton()
    }

    private func configureView() {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 350).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 132).isActive = true
    }

    private func configureimageBackgroundView() {
        addSubview(imageBackgroundView)
        imageBackgroundView.backgroundColor = .grayForGround
        imageBackgroundView.layer.cornerRadius = 12
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        imageBackgroundView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        imageBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageBackgroundView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func configureCentrImageView() {
        imageBackgroundView.addSubview(centrImageView)
        centrImageView.translatesAutoresizingMaskIntoConstraints = false
        centrImageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor).isActive = true
        centrImageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor).isActive = true
    }

    private func configureLabel() {
        titleLabel.font = .verdana14
        titleLabel.textColor = .grayForText
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 17).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }

    private func configureButton() {
        addSubview(reloadButton)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.layer.cornerRadius = 12
        reloadButton.backgroundColor = .grayForGround
        reloadButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        reloadButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        configureReloadImage()
        configureReloadLabel()
    }

    private func configureReloadImage() {
        reloadButton.addSubview(reloadImageView)
        reloadImageView.translatesAutoresizingMaskIntoConstraints = false
        reloadImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        reloadImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        reloadImageView.leadingAnchor.constraint(equalTo: reloadButton.leadingAnchor, constant: 41).isActive = true
        reloadImageView.centerYAnchor.constraint(equalTo: reloadButton.centerYAnchor).isActive = true
    }

    private func configureReloadLabel() {
        reloadButton.addSubview(reloadLabel)
        reloadLabel.translatesAutoresizingMaskIntoConstraints = false
        reloadLabel.widthAnchor.constraint(equalToConstant: 46).isActive = true
        reloadLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        reloadLabel.trailingAnchor.constraint(equalTo: reloadButton.trailingAnchor, constant: -40).isActive = true
        reloadLabel.centerYAnchor.constraint(equalTo: reloadButton.centerYAnchor).isActive = true
        reloadLabel.font = .verdana14
        reloadLabel.textColor = .grayForText
    }
}
