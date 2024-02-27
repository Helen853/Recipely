// Info.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о пользователе
struct Info: CellTypeProtocol {
    // тип ячейки
    var cellType: CellsTypes = .info
    // фото пользователя
    let imageName: String
    // Фамилия и имя пользователя
    let fullName: String
}
