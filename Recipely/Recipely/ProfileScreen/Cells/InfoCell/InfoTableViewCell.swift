// InfoTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с информацией о пользователе
class InfoTableViewCell: UITableViewCell {
    private let avatarImageView = UIImageView()
    private let fullNameLabel = UILabel()
    private let changeButton = UIButton()
    var onTapHandler: (() -> ())?

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

    func configureCell(model: Info, tapButton: (() -> ())?) {
        avatarImageView.image = UIImage(named: model.imageName)
        fullNameLabel.text = model.fullName
        onTapHandler = tapButton
    }

    func configureAvatar() {
        contentView.addSubview(avatarImageView)
        avatarImageView.clipsToBounds = true
//        avatarImageView.layer.cornerRadius = 15
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 115).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
    }

    func configureLabel() {
        contentView.addSubview(fullNameLabel)
        fullNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        fullNameLabel.textColor = #colorLiteral(red: 0.3469149768, green: 0.4360020161, blue: 0.475877285, alpha: 1)
        fullNameLabel.textAlignment = .right
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        fullNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 51).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 26).isActive = true
        fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29).isActive = true
    }

    func configureButton() {
        contentView.addSubview(changeButton)
        changeButton.setImage(UIImage(named: AppConstants.changeImageName), for: .normal)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        changeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        changeButton.leadingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor, constant: 8).isActive = true
        changeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32).isActive = true
        changeButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }

    @objc func onTap() {
        onTapHandler?()
    }
}
