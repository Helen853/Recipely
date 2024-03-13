// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные с рецептом
public final class Recipe: Identifiable {
    // Картинка еды
    var imageFoodName: String
    // Название еды
    var foodName: String
    // Время готовки еды
    var foodTime: Double
    // Калории
    var foodKkal: Double

    // MARK: - Initializers

    init(dto: RecipeDTO) {
        imageFoodName = dto.image
        foodName = dto.label
        foodTime = dto.totalTime
        foodKkal = dto.calories
    }
}
