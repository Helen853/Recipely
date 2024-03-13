// RecipeDetailResponseDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура детальных рецептов
struct RecipeDetailResponseDTO: Codable {
    /// Массив с подробными рецептами
    let hits: [RecipeDetailHitDTO]
}
