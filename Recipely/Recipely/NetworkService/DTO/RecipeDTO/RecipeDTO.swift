// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рецепт
struct RecipeDTO: Codable {
    /// Картинка рецепта
    let image: String
    /// Название рецепта
    let label: String
    /// Время приготовления
    let totalTime: Double
    /// Калории
    let calories: Double
    /// URI
    let uri: String
}
