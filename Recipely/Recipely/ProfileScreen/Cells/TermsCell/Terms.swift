// Terms.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ячейка с условиями
struct Terms: CellTypeProtocol {
    // тип ячейки
    var cellType: CellsTypes = .terms
    // картинка в ячейке
    let imageName: String
    // название ячейки
    let itemTitle: String
}
