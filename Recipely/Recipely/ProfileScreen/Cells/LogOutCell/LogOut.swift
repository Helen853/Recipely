// LogOut.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Элементы
struct LogOut: CellTypeProtocol {
    // тип ячейки
    var cellType: CellsTypes = .logOut
    // картинка в ячейке
    let imageName: String
    // название ячейки
    let itemTitle: String
}
