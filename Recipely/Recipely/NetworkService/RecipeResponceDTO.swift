// RecipeResponceDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// RecipeResponseDTO
struct RecipeResponseDTO: Codable {
    /// Массив с рецептами
    let hits: [RecipeHitDTO]
}

/// RecipeHitDTO
struct RecipeHitDTO: Codable {
    /// Рецепт
    let recipe: RecipeDTO
}

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
