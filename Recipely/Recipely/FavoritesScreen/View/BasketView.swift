// BasketView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Надпись когда фавориты пустые
final class BasketView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let fontVerdanaBold = "Verdana-Bold"
        static let fontVerdana = "Verdana"
        static let viewTitle = "There's nothing here yet"
        static let viewText = "Add interesting recipes to make ordering products convenient"
        static let viewImageName = "emptyFavorites"
    }

    // MARK: - Visual Components

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.viewTitle
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewText: UILabel = {
        let label = UILabel()
        label.text = Constants.viewText
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.textColor = UIColor(red: 151 / 255, green: 162 / 255, blue: 176 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private let viewImageBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 242 / 255, green: 245 / 255, blue: 250 / 255, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.viewImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupAnchors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupAnchors()
    }

    // MARK: - Private Methods

    private func setupViews() {
        addSubview(backgroundView)
        addSubview(viewText)
        addSubview(viewTitle)
        addSubview(viewImageBackground)
        addSubview(viewImage)
    }

    private func setupAnchors() {
        setupAnchorsBackgroundView()
        setupAnchorsViewImageBackground()
        setupvAnchorsViewTitle()
        setupvAnchorsViewText()
        setupAnchorsViewImage()
    }

    private func setupAnchorsBackgroundView() {
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 350).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 132).isActive = true
    }

    private func setupAnchorsViewImageBackground() {
        viewImageBackground.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        viewImageBackground.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        viewImageBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        viewImageBackground.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupvAnchorsViewTitle() {
        viewTitle.topAnchor.constraint(equalTo: viewImageBackground.bottomAnchor, constant: 17).isActive = true
        viewTitle.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }

    private func setupvAnchorsViewText() {
        viewText.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 17).isActive = true
        viewText.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        viewText.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func setupAnchorsViewImage() {
        viewImage.centerYAnchor.constraint(equalTo: viewImageBackground.centerYAnchor).isActive = true
        viewImage.centerXAnchor.constraint(equalTo: viewImageBackground.centerXAnchor).isActive = true
    }
}
