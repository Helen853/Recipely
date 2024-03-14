// ShimmerImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер для ячейки с картинкой
final class ShimmerImageTableViewCell: UITableViewCell {
    private enum Constants {
        static let gradientKey = "background"
    }
  
    // MARK: - VIsual Components
    private let titleLabel = UILabel()
    private let titleStackView = UIStackView()
    private let enercLabel = UILabel()
    private let carbohydratesLabel = UILabel()
    private let fatsLabel = UILabel()
    private let proteinLabel = UILabel()

    private var viewBackgroundGroup = CAAnimationGroup()
    private let gradientLayer = CAGradientLayer()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Life Cycle

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        setupViews()
    }
  
  private func setupViews() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(titleStackView)
    contentView.addSubview(enercLabel)
    contentView.addSubview(carbohydratesLabel)
    contentView.addSubview(fatsLabel)
    contentView.addSubview(proteinLabel)
  }

   
}
