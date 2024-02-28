// BonusesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с бонусами
final class BonusesTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let groundView = UIView()
    private let titleLabel = UILabel()
    private let arrowButton = UIButton()
    private let starImageView = UIImageView()

    // MARK: - Public Properties

    // кложура для нажатия стрелки в ячейке
    var arrowTapHandler: VoidHandler?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureGroundView()
        configureTitleLabel()
        configureStarImage()
        configureArrowButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureCell(model: Bonuses, tapButton: VoidHandler?) {
        configureImage(nameImage: model.imageName)
        configureLabel(title: model.itemTitle)
        arrowTapHandler = tapButton
    }

    // MARK: - Private Methods

    private func configureImage(nameImage: String) {
        starImageView.image = UIImage(named: nameImage)
    }

    private func configureLabel(title: String) {
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

    private func configureStarImage() {
        groundView.addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.widthAnchor.constraint(equalToConstant: 23.34).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 22.17).isActive = true
        starImageView.centerYAnchor.constraint(equalTo: groundView.centerYAnchor).isActive = true
        starImageView.centerXAnchor.constraint(equalTo: groundView.centerXAnchor).isActive = true
    }

    private func configureArrowButton() {
        contentView.addSubview(arrowButton)
        arrowButton.setImage(UIImage(named: AppConstants.arrowName), for: .normal)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        arrowButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }

    @objc private func tappedButton() {
        arrowTapHandler?()
    }
}
