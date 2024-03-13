// TextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с текстом рецепта
final class TextTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    private let recipeLabel = UILabel()
    private let gradientLayer = CAGradientLayer()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureRadius()
        configureText()
        configureGradient()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = contentView.bounds
    }

    // MARK: - Public Methods

    func configureCell(model: Text) {
        recipeLabel.text = model.recipe.joined()
    }

    // MARK: - Private Methods

    private func configureRadius() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 24
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureText() {
        contentView.addSubview(recipeLabel)
        recipeLabel.font = .verdana14
        recipeLabel.textColor = .black
        recipeLabel.numberOfLines = 0
        recipeLabel.textAlignment = .left

        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27).isActive = true
        recipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27).isActive = true
        recipeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    private func configureGradient() {
        gradientLayer.colors = [
            CGColor.turquoiseForGradient,
            CGColor.whiteForGradient
        ]
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
