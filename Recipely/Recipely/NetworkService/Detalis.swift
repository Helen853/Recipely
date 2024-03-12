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
    let images: ImagesDTO
    /// Масса рецепта
    let totalWeight: Double
    /// КБЖУ
    let totalNutrients: TotalNutrientsDTO

    // MARK: - Initializers

    init(dto: RecipeDetailDTO) {
        label = dto.label
        totalTime = dto.totalTime
        images = dto.images
        totalWeight = dto.totalWeight
        totalNutrients = dto.totalNutrients
    }
}
