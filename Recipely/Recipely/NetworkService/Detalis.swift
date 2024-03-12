// Detalis.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные для таблицы с подробным рецептом
public final class Detalis: Identifiable {
    // MARK: - Public Properties

    /// Название
    let label: String
    /// Время пригтовления
    let totalTime: Double
    /// Калории
    let calories: Double
    /// Картинка рецепта
    let images: ImagesDTO
    /// Масса рецепта
    let totalWeight: Double
    /// КБЖУ
    let totalNutrients: TotalNutrientsDTO

    // MARK: - Initializers

    init(dto: RecipeDTO) {
        label = dto.label
        totalTime = dto.totalTime
        calories = dto.calories
        images = dto.images
        totalWeight = dto.totalWeight
        totalNutrients = dto.totalNutrients
    }
}
