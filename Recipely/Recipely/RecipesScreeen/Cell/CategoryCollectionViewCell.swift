// CategoryCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с категорией рецептов
final class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    var categoryTapHandler: ((_ type: CategoryCellType) -> ())?
    var category: Category?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
        configureLable()
        configureContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureCell(model: Category, handler: ((_ type: CategoryCellType) -> ())?) {
        category = model
        imageView.image = UIImage(named: model.imageName)
        configureTextLabel(model: model)
        categoryTapHandler = handler
    }

    // MARK: - Private Methods

    private func configureContentView() {
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 5
    }

    private func configureTextLabel(model: Category) {
        titleLabel.text = model.categoryName
        titleLabel.font = UIFont.systemFont(ofSize: model.sizeText)
        titleLabel.heightAnchor.constraint(equalToConstant: model.hightTitle).isActive = true
    }

    private func configureImage() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 18
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }

    private func configureLable() {
        imageView.addSubview(titleLabel)
        titleLabel.backgroundColor = #colorLiteral(red: 0.5957052112, green: 0.6146538258, blue: 0.6359308362, alpha: 0.7136020281)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    @objc private func tappedImage() {
        categoryTapHandler?(category?.categoryType ?? .chicken)
    }
}