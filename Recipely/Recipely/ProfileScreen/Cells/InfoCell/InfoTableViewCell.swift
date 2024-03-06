// InfoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с информацией о пользователе
final class InfoTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let avatarImageView = UIImageView()
    private let fullNameLabel = UILabel()
    private let changeButton = UIButton()

    // MARK: - Public Properties

    var onTapHandler: VoidHandler?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAvatar()
        configureLabel()
        configureButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureCell(model: Info, tapButton: VoidHandler?) {
        configureImage(nameImage: model.imageName)
        configureLabel(title: model.fullName)
        onTapHandler = tapButton
    }

    // MARK: - Private Methods

    private func configureImage(nameImage: String) {
        avatarImageView.image = UIImage(named: nameImage)
    }

    private func configureLabel(title: String) {
        fullNameLabel.text = title
    }

    private func configureAvatar() {
        contentView.addSubview(avatarImageView)
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 115).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
    }

    private func configureLabel() {
        contentView.addSubview(fullNameLabel)
        fullNameLabel.font = .verdanaBold25
        fullNameLabel.textColor = .grayForTitle
        fullNameLabel.textAlignment = .right
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        fullNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 51).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 26).isActive = true
        fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29).isActive = true
    }

    private func configureButton() {
        contentView.addSubview(changeButton)
        changeButton.setImage(UIImage(named: AppConstants.changeImageName), for: .normal)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        changeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        changeButton.leadingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor, constant: 8).isActive = true
        changeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32).isActive = true
        changeButton.addTarget(self, action: #selector(onTapChangeName), for: .touchUpInside)
    }

    @objc private func onTapChangeName() {
        onTapHandler?()
    }
}
