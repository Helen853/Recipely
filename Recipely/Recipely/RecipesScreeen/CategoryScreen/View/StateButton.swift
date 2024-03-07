// StateButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class StateButton: UIButton {
    // MARK: - Private Properties

    private var title: String
    private var image: UIImage

    // MARK: - Initializers

    init(title: String, image: UIImage) {
        self.image = image
        self.title = title
        super.init(frame: .zero)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        title = ""
        image = UIImage()
        super.init(coder: coder)
    }

    private func configureView() {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        backgroundColor = .grayForGround
        titleLabel?.font = .verdana16
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 20
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 10)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
