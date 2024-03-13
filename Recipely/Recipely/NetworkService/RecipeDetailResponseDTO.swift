// RecipeDetailResponseDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// RecipeDetailResponseDTO
struct RecipeDetailResponseDTO: Codable {
    /// Массив с подробными рецептами
    let hits: [RecipeDetailHitDTO]
}

/// RecipeDetailHitDTO
struct RecipeDetailHitDTO: Codable {
    /// Подробный рецепт
    let recipe: RecipeDetailDTO
}

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

/// ImagesDTO
struct ImagesDTO: Codable {
    /// Размер фотографии
    let regular: LargeDTO

    /// Названия ключей
    enum CodingKeys: String, CodingKey {
        /// замена key regular
        case regular = "REGULAR"
    }
}

/// LargeDTO
struct LargeDTO: Codable {
    /// Ссылка на фотографию
    let url: String
}

/// КБЖУ для детального рецепта
struct TotalNutrientsDTO: Codable {
    /// Калории
    let calories: TotalDTO
    /// Жиры
    let fat: TotalDTO
    /// Белки
    let protein: TotalDTO
    /// Углеводы
    let chocdf: TotalDTO

    /// Названия ключей
    enum CodingKeys: String, CodingKey {
        /// Ключ calories
        case calories = "ENERC_KCAL"
        /// Ключ fat
        case fat = "CHOCDF"
        /// Ключ protein
        case protein = "FAT"
        /// Ключ chocdf
        case chocdf = "PROCNT"
    }
}

/// TotalDTO
struct TotalDTO: Codable {
    /// Количество КБЖУ
    let quantity: Double
}