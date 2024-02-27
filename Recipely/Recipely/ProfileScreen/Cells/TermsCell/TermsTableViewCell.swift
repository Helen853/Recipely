// TermsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с условиями
class TermsTableViewCell: UITableViewCell {
    let groundView = UIView()
    let titleLabel = UILabel()
    let arrowButton = UIButton()
    let termsImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureGroundView()
        configureTitleLabel()
        configureTermsImage()
        configureArrowButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(model: Terms) {
        termsImageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.itemTitle
    }

    func configureGroundView() {
        contentView.addSubview(groundView)
        groundView.backgroundColor = #colorLiteral(red: 0.9559337497, green: 0.9685742259, blue: 0.9688379169, alpha: 1)
        groundView.layer.cornerRadius = 12
        groundView.translatesAutoresizingMaskIntoConstraints = false
        groundView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        groundView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        groundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        groundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        groundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
    }

    func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = #colorLiteral(red: 0.3469149768, green: 0.4360020161, blue: 0.475877285, alpha: 1)
        // titleLabel.textAlignment = .right
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 224).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: groundView.trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    func configureTermsImage() {
        groundView.addSubview(termsImageView)
        termsImageView.translatesAutoresizingMaskIntoConstraints = false
        termsImageView.tintColor = #colorLiteral(red: 0.5131713152, green: 0.7742882967, blue: 0.7948206067, alpha: 1)

        termsImageView.widthAnchor.constraint(equalToConstant: 19.83).isActive = true
        termsImageView.heightAnchor.constraint(equalToConstant: 23.33).isActive = true
        termsImageView.centerYAnchor.constraint(equalTo: groundView.centerYAnchor).isActive = true
        termsImageView.centerXAnchor.constraint(equalTo: groundView.centerXAnchor).isActive = true
    }

    func configureArrowButton() {
        contentView.addSubview(arrowButton)
        arrowButton.setImage(UIImage(named: AppConstants.arrowName), for: .normal)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
