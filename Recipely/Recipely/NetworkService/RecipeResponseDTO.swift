// RecipeResponseDTO.swift
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

/// RecipeDTO
struct RecipeDTO: Codable {
    /// Картинка рецепта
    let image: String
    /// Название рецепта
    let label: String
    /// Время приготовления
    let totalTime: Double
    /// Калории
    let calories: Double
    /// Картинка для детального рецепта
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

/// TotalNutrientsDTO
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
