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
    // тип категории
    var categoryType: CategoryCellType
}

/// Енам для типов ячеек
enum CellType {
    case small
    case medium
    case large
}

/// Енам с типом категорий ячеек
enum CategoryCellType {
    case salad
    case soup
    case chicken
    case meat
    case fish
    case sideDish
    case drinks
    case pancake
    case desserts
}
