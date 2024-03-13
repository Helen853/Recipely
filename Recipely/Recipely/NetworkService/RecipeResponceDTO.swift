// RecipeResponceDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура представляющая блюда
struct RecipeResponseDTO: Codable {
    /// Массив с рецептами
    let hits: [RecipeHitDTO]
}

/// Структура представляющее кокретное блюдо
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
