// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категории рецептов
struct Category {
    /// тип ячейки
    var cellType: CellType
    // картинка категории
    var imageName: String
    // название категории
    var categoryName: String
    // высота лейбла
    var hightTitle: CGFloat
    // размер шрифта
    var sizeText: CGFloat
}

/// Енам для типов ячеек
enum CellType {
    case small
    case medium
    case large
}
