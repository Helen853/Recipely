// Bonuses.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ячейка с бонусами
struct Bonuses: CellTypeProtocol {
    // тип ячейки
    var cellType: CellsTypes = .bonuses
    // картинка в ячейке
    let imageName: String
    // название ячейки
    let itemTitle: String
}
