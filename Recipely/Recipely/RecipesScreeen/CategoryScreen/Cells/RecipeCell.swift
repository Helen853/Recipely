// RecipeCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с едой
final class FoodCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdana = "Verdana"
        static let timerImageViewName = "timer"
        static let pizzaImageViewName = "pizza"
        static let nextButtonImageName = "goToDetailsArrow"
        static let timeLabelText = " min"
        static let pizzaLabelText = " kkal"
    }

    var tappedNextHandler: VoidHandler?

    // MARK: - VIsual Components

    private let uiViewBackground: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        uiView.layer.cornerRadius = 12
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleRecipe: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.timerImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.pizzaImageViewName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.fontVerdana, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.nextButtonImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        setupAnchors()
        addTargetNextButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupAnchors()
    }

    // MARK: - Public Methods

    func configure(with items: Recipes, handler: VoidHandler?) {
        recipeImageView.image = UIImage(named: items.imageFoodName)
        titleRecipe.text = items.foodName
        timeLabel.text = String(items.foodTime) + Constants.timeLabelText
        pizzaLabel.text = String(items.foodKkal) + Constants.pizzaLabelText
        tappedNextHandler = handler
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.addSubview(uiViewBackground)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipe)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timerImageView)
        contentView.addSubview(pizzaImageView)
        contentView.addSubview(pizzaLabel)
        contentView.addSubview(nextButton)
    }

    private func setupAnchors() {
        setupAnchorsUiViewBackground()
        setupAnchorsRecipeImageView()
        setupAnchorsTitleRecipe()
        setupAnchorsTimeLabel()
        setupAnchorsTimerImageView()
        setupAnchorsPizzaImageView()
        setupAnchorsPizzaLabel()
        setupAnchorsNextButton()
    }

    private func setupAnchorsUiViewBackground() {
        uiViewBackground.widthAnchor.constraint(equalToConstant: 338).isActive = true
        uiViewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        uiViewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        uiViewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
    }

    private func setupAnchorsRecipeImageView() {
        recipeImageView.leadingAnchor.constraint(equalTo: uiViewBackground.leadingAnchor, constant: 10).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 10).isActive = true
    }

    private func setupAnchorsTitleRecipe() {
        titleRecipe.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 22).isActive = true
        titleRecipe.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        titleRecipe.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setupAnchorsTimeLabel() {
        timeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 40).isActive = true
        timeLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
    }

    private func setupAnchorsTimerImageView() {
        timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 22).isActive = true
        timerImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaImageView() {
        pizzaImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 37).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaLabel() {
        pizzaLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 55).isActive = true
        pizzaLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
    }

    private func setupAnchorsNextButton() {
        nextButton.trailingAnchor.constraint(equalTo: uiViewBackground.trailingAnchor, constant: -16).isActive = true
        nextButton.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 40).isActive = true
    }

    private func addTargetNextButton() {
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
    }

    @objc func tappedNextButton() {
        tappedNextHandler?()
    }
}
