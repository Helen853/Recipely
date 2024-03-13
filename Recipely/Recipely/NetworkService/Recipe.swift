// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные с рецептом
final class Recipes: Decodable, Encodable {
    // MARK: - Public Properties

    // Картинка еды
    var imageFoodName: String
    // Название еды
    var foodName: String
    // Время приготовления
    var foodTime: Double
    // Калорийность блюда
    var foodKkal: Double

    init(dto: RecipeDTO) {
        imageFoodName = dto.image
        foodName = dto.label
        foodTime = dto.totalTime
        foodKkal = dto.calories
    }
}
