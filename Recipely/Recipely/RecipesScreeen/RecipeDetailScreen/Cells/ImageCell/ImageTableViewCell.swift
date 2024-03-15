// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой рецепта
final class ImageTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let titleLabel = UILabel()
    private let foodImageView = UIImageView()
    private let massaView = UIView()
    private let timeView = UIView()
    private let potImageView = UIImageView()
    private let massaLabel = UILabel()
    private let timeImageView = UIImageView()
    private let timeTextLabel = UILabel()
    private let timeLabel = UILabel()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTitle()
        configureImage()
        configureGroundView()
        configurePot()
        configureMassa()
        configureTimeView()
        configureTimeImage()
        configureTimeText()
        configureTimeLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureCell(model: Image) {
        titleLabel.text = model.title
        massaLabel.text = model.massa
        timeLabel.text = model.timeText
    }

    func configureImage(image: UIImage) {
        foodImageView.image = image
    }

    // MARK: - Private Methods

    private func configureTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.font = .verdanaBold20
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    private func configureImage() {
        contentView.addSubview(foodImageView)
        foodImageView.clipsToBounds = true
        foodImageView.layer.cornerRadius = 24
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        foodImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        foodImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        foodImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        foodImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    private func configureGroundView() {
        foodImageView.addSubview(massaView)
        massaView.backgroundColor = .turquoiseOpasity
        massaView.layer.cornerRadius = 25
        massaView.translatesAutoresizingMaskIntoConstraints = false
        massaView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        massaView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        massaView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -6).isActive = true
        massaView.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 8).isActive = true
    }

    private func configurePot() {
        massaView.addSubview(potImageView)
        potImageView.image = UIImage(named: AppConstants.potImageName)
        potImageView.clipsToBounds = true
        potImageView.translatesAutoresizingMaskIntoConstraints = false
        potImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        potImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        potImageView.centerXAnchor.constraint(equalTo: massaView.centerXAnchor).isActive = true
        potImageView.topAnchor.constraint(equalTo: massaView.topAnchor, constant: 7).isActive = true
    }

    private func configureMassa() {
        massaView.addSubview(massaLabel)
        massaLabel.textAlignment = .center
        massaLabel.font = .verdana10
        massaLabel.textColor = .white
        massaLabel.translatesAutoresizingMaskIntoConstraints = false
        massaLabel.widthAnchor.constraint(equalToConstant: 39.17).isActive = true
        massaLabel.heightAnchor.constraint(equalToConstant: 15.63).isActive = true
        massaLabel.centerXAnchor.constraint(equalTo: massaView.centerXAnchor).isActive = true
        massaLabel.bottomAnchor.constraint(equalTo: massaView.bottomAnchor, constant: -6.38).isActive = true
    }

    private func configureTimeView() {
        foodImageView.addSubview(timeView)
        timeView.backgroundColor = .turquoiseOpasity
        timeView.layer.cornerRadius = 24
        timeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        timeView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        timeView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor).isActive = true
        timeView.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor).isActive = true
    }

    private func configureTimeImage() {
        timeView.addSubview(timeImageView)
        timeImageView.image = UIImage(named: AppConstants.clockImageName)
        timeImageView.clipsToBounds = true
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        timeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        timeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        timeImageView.centerYAnchor.constraint(equalTo: timeView.centerYAnchor).isActive = true
        timeImageView.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 8).isActive = true
    }

    private func configureTimeText() {
        timeView.addSubview(timeTextLabel)
        timeTextLabel.textAlignment = .center
        timeTextLabel.text = AppConstants.timeText
        timeTextLabel.font = .verdana10
        timeTextLabel.textColor = .white
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTextLabel.widthAnchor.constraint(equalToConstant: 83).isActive = true
        timeTextLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeTextLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -8).isActive = true
        timeTextLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 10).isActive = true
    }

    private func configureTimeLabel() {
        timeView.addSubview(timeLabel)
        timeLabel.textAlignment = .center
        timeLabel.font = .verdana10
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -26).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -8).isActive = true
    }
}
