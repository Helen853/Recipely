// RecipeResponceDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура представляющая блюда
struct RecipeResponseDTO: Codable {
    /// Массив с рецептами
    let hits: [RecipeHitDTO]
}
