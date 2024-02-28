// LogOut.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ячейка выхода с профиля
struct LogOut: CellTypeProtocol {
    // тип ячейки
    var cellType: CellsTypes = .logOut
    // картинка в ячейке
    let imageName: String
    // название ячейки
    let itemTitle: String
}
