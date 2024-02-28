// BonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран бонусов
final class BonusesViewController: UIViewController {
    // MARK: - Visual Components

    private let titleLabel = UILabel()
    private let boxImageView = UIImageView()
    private let starImageView = UIImageView()
    private let countBonusesLabel = UILabel()
    private let closeButton = UIButton()

    // MARK: - Public Properties

    var bonusesPresenter: BonusesPresenter?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTitle()
        configureImageBox()
        configureImageStar()
        configureCountLabel()
        configureCloseButton()
    }

    // MARK: - Private Methods

    private func configureView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
    }

    private func configureTitle() {
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = AppConstants.bonusesTitle
        titleLabel.textColor = #colorLiteral(red: 0.3469149768, green: 0.4360020161, blue: 0.475877285, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46).isActive = true
    }

    private func configureImageBox() {
        view.addSubview(boxImageView)
        boxImageView.image = UIImage(named: AppConstants.boxImageName)
        boxImageView.translatesAutoresizingMaskIntoConstraints = false
        boxImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        boxImageView.heightAnchor.constraint(equalToConstant: 136.2).isActive = true
        boxImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13).isActive = true
        boxImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func configureImageStar() {
        view.addSubview(starImageView)
        starImageView.image = UIImage(named: AppConstants.starImageName)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.widthAnchor.constraint(equalToConstant: 29.17).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 27.71).isActive = true
        starImageView.topAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 31.45).isActive = true
        starImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143.92).isActive = true
    }

    private func configureCountLabel() {
        view.addSubview(countBonusesLabel)
        countBonusesLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        countBonusesLabel.text = AppConstants.countBonusesText
        countBonusesLabel.textColor = #colorLiteral(red: 0.3469149768, green: 0.4360020161, blue: 0.475877285, alpha: 1)
        countBonusesLabel.translatesAutoresizingMaskIntoConstraints = false
        countBonusesLabel.widthAnchor.constraint(equalToConstant: 177).isActive = true
        countBonusesLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        countBonusesLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 13.91)
            .isActive = true
        countBonusesLabel.topAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 27.8).isActive = true
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
        bonusesPresenter?.closeBonuses()
    }
}
