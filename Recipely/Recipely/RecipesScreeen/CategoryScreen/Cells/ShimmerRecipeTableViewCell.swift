// ShimmerRecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шимер ячейка рецепта
final class ShimmerRecipeTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let gradientKey = "background"
    }

    // MARK: - VIsual Components

    private let uiViewBackground: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 12
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private let recipeImageView = UIImageView()
    private let titleRecipe = UILabel()
    private let timeLabel = UILabel()
    private let timerImageView = UIImageView()
    private let pizzaImageView = UIImageView()
    private let pizzaLabel = UILabel()
    public let nextButton = UIButton()

    // MARK: - Private Properties

    private var viewBackgroundGroup = CAAnimationGroup()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupViews()
        setupAnchors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupAnchors()
    }

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradientBackground()
        addGradientImage()
        addGradientTitle()
        addGradientTimeLabel()
        addGradientPizzaLabel()
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
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.leadingAnchor.constraint(equalTo: uiViewBackground.leadingAnchor, constant: 10).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 10).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    private func setupAnchorsTitleRecipe() {
        titleRecipe.translatesAutoresizingMaskIntoConstraints = false
        titleRecipe.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 22).isActive = true
        titleRecipe.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        titleRecipe.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleRecipe.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupAnchorsTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        timeLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 74).isActive = true
    }

    private func setupAnchorsTimerImageView() {
        timerImageView.translatesAutoresizingMaskIntoConstraints = false
        timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 22).isActive = true
        timerImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaImageView() {
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 37).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 19).isActive = true
    }

    private func setupAnchorsPizzaLabel() {
        pizzaLabel.translatesAutoresizingMaskIntoConstraints = false
        pizzaLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 35).isActive = true
        pizzaLabel.topAnchor.constraint(equalTo: titleRecipe.bottomAnchor, constant: 20).isActive = true
        pizzaLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pizzaLabel.widthAnchor.constraint(equalToConstant: 91).isActive = true
    }

    private func setupAnchorsNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.trailingAnchor.constraint(equalTo: uiViewBackground.trailingAnchor, constant: -16).isActive = true
        nextButton.topAnchor.constraint(equalTo: uiViewBackground.topAnchor, constant: 40).isActive = true
    }

    private func addGradientBackground() {
        let gradientBackground = CAGradientLayer()
        gradientBackground.startPoint = CGPoint(x: 0, y: 0.5)
        gradientBackground.endPoint = CGPoint(x: 1, y: 0.5)
        gradientBackground.frame = uiViewBackground.bounds
        gradientBackground.cornerRadius = 12
        uiViewBackground.layer.addSublayer(gradientBackground)

        viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientBackground.add(viewBackgroundGroup, forKey: Constants.gradientKey)
    }

    private func addGradientImage() {
        let gradientImage = CAGradientLayer()
        gradientImage.startPoint = CGPoint(x: 0, y: 0.5)
        gradientImage.endPoint = CGPoint(x: 1, y: 0.5)
        gradientImage.cornerRadius = 12
        gradientImage.frame = recipeImageView.bounds
        recipeImageView.layer.addSublayer(gradientImage)

        let imageGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientImage.add(imageGroup, forKey: Constants.gradientKey)
    }

    private func addGradientTitle() {
        let gradientTitle = CAGradientLayer()
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = titleRecipe.bounds
        titleRecipe.layer.addSublayer(gradientTitle)

        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTitle.add(titleGroup, forKey: Constants.gradientKey)
    }

    private func addGradientTimeLabel() {
        let gradientTimelabel = CAGradientLayer()
        gradientTimelabel.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTimelabel.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTimelabel.frame = timeLabel.bounds
        timeLabel.layer.addSublayer(gradientTimelabel)

        let timeGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTimelabel.add(timeGroup, forKey: Constants.gradientKey)
    }

    private func addGradientPizzaLabel() {
        let gradientPizzalabel = CAGradientLayer()
        gradientPizzalabel.startPoint = CGPoint(x: 0, y: 0.5)
        gradientPizzalabel.endPoint = CGPoint(x: 1, y: 0.5)
        gradientPizzalabel.frame = pizzaLabel.bounds
        pizzaLabel.layer.addSublayer(gradientPizzalabel)

        let pizzaGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientPizzalabel.add(pizzaGroup, forKey: Constants.gradientKey)
    }

    private func makeAnimation(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5

        let animationFirst = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animationFirst.fromValue = UIColor.lightGray.cgColor
        animationFirst.toValue = UIColor.white.cgColor
        animationFirst.duration = animDuration
        animationFirst.beginTime = 0.0

        let animationSecond = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animationSecond.fromValue = UIColor.white.cgColor
        animationSecond.toValue = UIColor.lightGray.cgColor
        animationSecond.duration = animDuration
        animationSecond.beginTime = animationFirst.beginTime + animationSecond.duration

        let group = CAAnimationGroup()
        group.animations = [animationFirst, animationSecond]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = animationSecond.beginTime + animationFirst.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        return group
    }
}
