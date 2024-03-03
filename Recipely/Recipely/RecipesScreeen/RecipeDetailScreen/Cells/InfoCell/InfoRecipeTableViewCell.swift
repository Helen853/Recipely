// InfoRecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с информацией о рецепте (КБЖУ)
final class InfoRecipeTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let titleStackView = UIStackView()
    private let enercLabel = UILabel()
    private let carbohydratesLabel = UILabel()
    private let fatsLabel = UILabel()
    private let proteinLabel = UILabel()
    private let numberStackView = UIStackView()
    private let numberEnercLabel = UILabel()
    private let numberCarbohydratesLabel = UILabel()
    private let numberFatsLabel = UILabel()
    private let numberProteinLabel = UILabel()
    private let colorView = UIView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTitleStack()
        configureNumberStack()
        setuppTitleLabel()
        setuppNumberLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureCell(model: InfoRecipe) {
        numberEnercLabel.text = model.countEnerc
        numberCarbohydratesLabel.text = model.countCarbohydrate
        numberFatsLabel.text = model.countFats
        numberProteinLabel.text = model.countProtein
    }

    // MARK: - Private Methods

    private func configureTitleStack() {
        contentView.addSubview(titleStackView)
        titleStackView.axis = .horizontal
        titleStackView.spacing = 5
        titleStackView.distribution = .fillEqually
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39).isActive = true
        titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    private func configureTitleLabel(nameLabel: UILabel, text: String) {
        nameLabel.font = UIFont.systemFont(ofSize: 10)
        nameLabel.textColor = .white
        nameLabel.text = text
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = #colorLiteral(red: 0.5053491592, green: 0.7708839774, blue: 0.7914870381, alpha: 1)
        nameLabel.layer.cornerRadius = 16
        nameLabel.clipsToBounds = true
        nameLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleStackView.addArrangedSubview(nameLabel)
    }

    private func setuppTitleLabel() {
        configureTitleLabel(nameLabel: enercLabel, text: AppConstants.enerc)
        configureTitleLabel(nameLabel: carbohydratesLabel, text: AppConstants.carbohydrates)
        configureTitleLabel(nameLabel: fatsLabel, text: AppConstants.fats)
        configureTitleLabel(nameLabel: proteinLabel, text: AppConstants.protein)
    }

    private func configureNumberStack() {
        contentView.addSubview(numberStackView)
        numberStackView.axis = .horizontal
        numberStackView.spacing = 5
        numberStackView.distribution = .fillEqually
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        numberStackView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        numberStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        numberStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39).isActive = true
        numberStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor).isActive = true
        numberStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    private func configureNumberLabel(nameLabel: UILabel) {
        nameLabel.font = UIFont(name: AppConstants.fontVerdana, size: 10)
        nameLabel.textColor = #colorLiteral(red: 0.5053491592, green: 0.7708839774, blue: 0.7914870381, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.layer.borderWidth = 2
        nameLabel.layer.borderColor = #colorLiteral(red: 0.5053491592, green: 0.7708839774, blue: 0.7914870381, alpha: 1)
        nameLabel.layer.cornerRadius = 16
        nameLabel.clipsToBounds = true
        nameLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        numberStackView.addArrangedSubview(nameLabel)
    }

    private func setuppNumberLabel() {
        configureNumberLabel(nameLabel: numberEnercLabel)
        configureNumberLabel(nameLabel: numberCarbohydratesLabel)
        configureNumberLabel(nameLabel: numberFatsLabel)
        configureNumberLabel(nameLabel: numberProteinLabel)
    }
}
