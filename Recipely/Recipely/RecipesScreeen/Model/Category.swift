// Category.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Категория рецептов
struct Category {
    /// тип размера
    var sizeType: SizeCellType
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
