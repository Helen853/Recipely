// ShimmerRecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ShimmerRecipeTableViewCell: UITableViewCell {
    // MARK: - VIsual Components

    private let uiViewBackground: UIView = {
        let uiView = UIView()
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
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let pizzaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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
        addGradient()
    }

//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }

    func setupLayer() {
        let gradientTitle = CAGradientLayer()
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)

        titleRecipe.layer.addSublayer(gradientTitle)
        // uiViewBackground.layer.addSublayer(gradient)
        // recipeImageView.layer.insertSublayer(gradient, at: 0)
//        timeLabel.layer.addSublayer(gradient)
//        pizzaLabel.layer.addSublayer(gradient)

        let animation = makeAnimation()
        animation.beginTime = 0.0
        gradientTitle.add(animation, forKey: "backgroundColor")

        gradientTitle.frame = titleRecipe.bounds
//      gradient.frame = uiViewBackground.bounds
//      gradient.cornerRadius = 12
//        gradient.frame = recipeImageView.bounds
//        gradient.frame = timeLabel.bounds
//        gradient.frame = pizzaLabel.bounds
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

    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)

        // titleRecipe.layer.addSublayer(gradient)
        uiViewBackground.layer.addSublayer(gradient)
        // recipeImageView.layer.insertSublayer(gradient, at: 0)
//      timeLabel.layer.addSublayer(gradient)
//      pizzaLabel.layer.addSublayer(gradient)

        let animation = makeAnimation()
        animation.beginTime = 0.0
        gradient.add(animation, forKey: "background")

//      gradient.frame = titleRecipe.bounds
        gradient.frame = uiViewBackground.bounds
        gradient.cornerRadius = 12
//      gradient.frame = recipeImageView.bounds
//      gradient.frame = timeLabel.bounds
//      gradient.frame = pizzaLabel.bounds
    }

    func addGradientImage() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        recipeImageView.layer.addSublayer(gradient)
        let animation = makeAnimation()
        animation.beginTime = 0.0
        gradient.add(animation, forKey: "background")
        gradient.frame = recipeImageView.bounds
    }

    func makeAnimation(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5

        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation.fromValue = UIColor.lightGray.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = animDuration
        animation.beginTime = 0.0

        let animation2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animation2.fromValue = UIColor.white.cgColor
        animation2.toValue = UIColor.lightGray.cgColor
        animation2.duration = animDuration
        animation2.beginTime = animation.beginTime + animation2.duration

        let group = CAAnimationGroup()
        group.animations = [animation, animation2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = animation2.beginTime + animation.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        return group
    }
}
