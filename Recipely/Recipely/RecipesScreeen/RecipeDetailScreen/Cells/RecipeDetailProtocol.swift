// RecipeDetailProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для типов ячеек экрана с подробным рецептом
protocol RecipeDetailProtocol {
    /// Тип ячейки
    var cellType: DetailType { get }
}
