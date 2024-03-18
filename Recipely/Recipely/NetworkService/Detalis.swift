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
    let images: String
    /// Вес блюда
    let totalWeight: Double
    /// Ингредиенты
    let ingridientsLines: String
    /// Жиры
    let fats: Double
    /// Протеин
    let proteins: Double
    /// Угливоды
    let chocdf: Double
    /// Калории
    let calories: Double

    init(dto: RecipeDetailHitDTO) {
        label = dto.recipe.label
        totalTime = dto.recipe.totalTime
        images = dto.recipe.images.regular.url
        totalWeight = dto.recipe.totalWeight
        fats = dto.recipe.totalNutrients.fat.quantity
        proteins = dto.recipe.totalNutrients.protein.quantity
        chocdf = dto.recipe.totalNutrients.chocdf.quantity
        calories = dto.recipe.totalNutrients.calories.quantity
        ingridientsLines = dto.recipe.ingredientLines.joined(separator: "\n")
    }

    init(recipeDetailsCD: RecipeDetailsCD) {
        label = recipeDetailsCD.label ?? ""
        totalTime = recipeDetailsCD.totalTime
        images = recipeDetailsCD.images ?? ""
        totalWeight = recipeDetailsCD.totalWeight
        calories = recipeDetailsCD.calories
        chocdf = recipeDetailsCD.chocdf
        fats = recipeDetailsCD.fats
        proteins = recipeDetailsCD.proteinn
        ingridientsLines = recipeDetailsCD.ingridientsLines ?? ""
    }
}
