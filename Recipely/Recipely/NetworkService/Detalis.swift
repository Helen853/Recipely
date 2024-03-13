// Detalis.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные для таблицы с подробным рецептом
final class Detalis {
    // MARK: - Public Properties

    // Название
    let label: String
    /// Время пригтовления
    let totalTime: Double
    // Картинка рецепта
    let images: ImagesDTO
    /// Вес блюда
    let totalWeight: Double
    // КБЖУ
    let totalNutrients: TotalNutrientsDTO
    /// Ингредиенты
    let ingridientsLines: [String]

    init(dto: RecipeDetailHitDTO) {
        label = dto.recipe.label
        totalTime = dto.recipe.totalTime
        images = dto.recipe.images
        totalWeight = dto.recipe.totalWeight
        totalNutrients = dto.recipe.totalNutrients
        ingridientsLines = dto.recipe.ingredientLines
    }
}
