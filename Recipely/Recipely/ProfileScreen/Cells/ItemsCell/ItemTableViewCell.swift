// ItemTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с элементами
class ItemTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(model: Item) {}
}
