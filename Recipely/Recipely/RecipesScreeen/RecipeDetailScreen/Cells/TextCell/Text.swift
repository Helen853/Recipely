// Text.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ячейка с текстом рецепта
struct Text: RecipeDetailProtocol {
    /// Тип ячейки
    var cellType: DetailType = .text
    /// Текст рецепта
    var recipe: [String]
}
