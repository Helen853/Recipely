// LogOutTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с выходом из профиля
final class LogOutTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let groundView = UIView()
    private let titleLabel = UILabel()
    private let arrowButton = UIButton()
    private let logoutImageView = UIImageView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureGroundView()
        configureTitleLabel()
        configureLogoutImage()
        configureArrowButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureCell(model: LogOut) {
        configureImage(nameImage: model.imageName)
        configureTitleLabel(title: model.itemTitle)
    }

    // MARK: - Private Methods

    private func configureImage(nameImage: String) {
        logoutImageView.image = UIImage(named: nameImage)
    }

    private func configureTitleLabel(title: String) {
        titleLabel.text = title
    }

    private func configureGroundView() {
        contentView.addSubview(groundView)
        groundView.backgroundColor = #colorLiteral(red: 0.9559337497, green: 0.9685742259, blue: 0.9688379169, alpha: 1)
        groundView.layer.cornerRadius = 12
        groundView.translatesAutoresizingMaskIntoConstraints = false
        groundView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        groundView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        groundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        groundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        groundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
    }

    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = #colorLiteral(red: 0.3469149768, green: 0.4360020161, blue: 0.475877285, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 224).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: groundView.trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    private func configureLogoutImage() {
        groundView.addSubview(logoutImageView)
        logoutImageView.translatesAutoresizingMaskIntoConstraints = false
        logoutImageView.widthAnchor.constraint(equalToConstant: 24.24).isActive = true
        logoutImageView.heightAnchor.constraint(equalToConstant: 23.33).isActive = true
        logoutImageView.centerYAnchor.constraint(equalTo: groundView.centerYAnchor).isActive = true
        logoutImageView.centerXAnchor.constraint(equalTo: groundView.centerXAnchor).isActive = true
    }

    private func configureArrowButton() {
        contentView.addSubview(arrowButton)
        arrowButton.setImage(UIImage(named: AppConstants.arrowName), for: .normal)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}