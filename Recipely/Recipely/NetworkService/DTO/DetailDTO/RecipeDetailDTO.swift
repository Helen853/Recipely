// RecipeDetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Подробный рецепт
struct RecipeDetailDTO: Codable {
    /// Название рецепта
    let label: String
    /// Время приготовления
    let totalTime: Double
    /// Калории
    let images: ImagesDTO
    /// Масса рецепта
    let totalWeight: Double
    /// КБЖУ
    let totalNutrients: TotalNutrientsDTO
    /// Описание рецепта
    let ingredientLines: [String]
}
