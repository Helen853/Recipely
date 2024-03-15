// ShimmerImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер для ячейки с картинкой
final class ShimmerImageTableViewCell: UITableViewCell {
    private enum Constants {
        static let gradientKey = "background"
    }

    private let imageShimmerView = UIView()
    private let titleLabel = UILabel()

    private let titleStackView = UIStackView()
    private let enercLabel = UILabel()
    private let carbohydratesLabel = UILabel()
    private let fatsLabel = UILabel()
    private let proteinLabel = UILabel()

    let uiGradientView = UIView()

    private var viewBackgroundGroup = CAAnimationGroup()
    private let gradientLayer = CAGradientLayer()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        configureTitle()
        configureView()
        configureTitleStack()
        setuppTitleLabel()
        configureGradientVew()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTitle()
        configureView()
        configureTitleStack()
        setuppTitleLabel()
        configureGradientVew()
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        addGradientImage()
        addGradientTitle()
        gradientLayer.frame = uiGradientView.bounds
    }

    private func configureView() {
        contentView.addSubview(imageShimmerView)
        imageShimmerView.clipsToBounds = true
        imageShimmerView.layer.cornerRadius = 24
        imageShimmerView.backgroundColor = .grayForGround
        imageShimmerView.translatesAutoresizingMaskIntoConstraints = false

        imageShimmerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageShimmerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        imageShimmerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageShimmerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func configureTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .grayForGround
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    private func addGradientImage() {
        let gradientImage = CAGradientLayer()
        gradientImage.startPoint = CGPoint(x: 0, y: 0.5)
        gradientImage.endPoint = CGPoint(x: 1, y: 0.5)
        gradientImage.cornerRadius = 12
        gradientImage.frame = imageShimmerView.bounds
        imageShimmerView.layer.addSublayer(gradientImage)

        viewBackgroundGroup = makeAnimation()
        viewBackgroundGroup.beginTime = 0.0
        gradientImage.add(viewBackgroundGroup, forKey: Constants.gradientKey)
    }

    private func addGradientTitle() {
        let gradientTitle = CAGradientLayer()
        gradientTitle.startPoint = CGPoint(x: 0, y: 0.5)
        gradientTitle.endPoint = CGPoint(x: 1, y: 0.5)
        gradientTitle.frame = titleLabel.bounds
        titleLabel.layer.addSublayer(gradientTitle)

        let titleGroup = makeAnimation(previousGroup: viewBackgroundGroup)
        gradientTitle.add(titleGroup, forKey: Constants.gradientKey)
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

    private func configureTitleStack() {
        contentView.addSubview(titleStackView)
        titleStackView.axis = .horizontal
        titleStackView.spacing = 5
        titleStackView.distribution = .fillEqually
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: imageShimmerView.bottomAnchor, constant: 40).isActive = true
        titleStackView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39).isActive = true
    }

    private func configureTitleLabel(nameLabel: UILabel) {
        nameLabel.layer.cornerRadius = 16
        nameLabel.clipsToBounds = true
        nameLabel.backgroundColor = .grayForGround
        titleStackView.addArrangedSubview(nameLabel)
    }

    private func setuppTitleLabel() {
        configureTitleLabel(nameLabel: enercLabel)
        configureTitleLabel(nameLabel: carbohydratesLabel)
        configureTitleLabel(nameLabel: fatsLabel)
        configureTitleLabel(nameLabel: proteinLabel)
    }

    private func configureGradient() {
        gradientLayer.colors = [
            CGColor.turquoiseForGradient,
            CGColor.whiteForGradient
        ]
        uiGradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func configureGradientVew() {
        contentView.addSubview(uiGradientView)
        uiGradientView.layer.cornerRadius = 16
        uiGradientView.translatesAutoresizingMaskIntoConstraints = false
        uiGradientView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20).isActive = true
        uiGradientView.backgroundColor = .grayForGround
        uiGradientView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        uiGradientView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        uiGradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        uiGradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        uiGradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        configureGradient()
    }
}
