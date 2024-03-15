// ErrorView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Плашка с ошибкой
final class ErrorView: UIView {
    // MARK: - Visual Components

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewText: UILabel = {
        let label = UILabel()
        label.font = .verdana14
        label.textColor = .grayForText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private let viewImageBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .grayForGround
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewImage = UIImageView()

    // MARK: - Initializers

    init(frame: CGRect, text: String, image: UIImage) {
        super.init(frame: .zero)
        viewText.text = text
        viewImage.image = image
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
        addSubview(viewImageBackground)
        addSubview(viewImage)
    }

    private func setupAnchors() {
        setupAnchorsBackgroundView()
        setupAnchorsViewImageBackground()
        setupvAnchorsViewText()
        setupAnchorsViewImage()
    }

    private func setupAnchorsBackgroundView() {
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 190).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 350).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 132).isActive = true
    }

    private func setupAnchorsViewImageBackground() {
        viewImageBackground.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        viewImageBackground.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        viewImageBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        viewImageBackground.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupvAnchorsViewText() {
        viewText.topAnchor.constraint(equalTo: viewImageBackground.bottomAnchor, constant: 17).isActive = true
        viewText.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        viewText.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func setupAnchorsViewImage() {
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        viewImage.centerYAnchor.constraint(equalTo: viewImageBackground.centerYAnchor).isActive = true
        viewImage.centerXAnchor.constraint(equalTo: viewImageBackground.centerXAnchor).isActive = true
    }
}
