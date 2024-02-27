// Item.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы
struct Item: CellTypeProtocol {
    // тип ячейки
    var cellType: CellsTypes = .item
    // картинка в ячейке
    let imageName: String
    // название ячейки
    let itemTitle: String
}
