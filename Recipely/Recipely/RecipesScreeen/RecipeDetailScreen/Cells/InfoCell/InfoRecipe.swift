// InfoRecipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ячейка с информацией о рецепте (КБЖУ)
struct InfoRecipe: RecipeDetailProtocol {
    // Тип ячейки
    var cellType: DetailType = .info
    // Кол-во калллорий
    var countEnerc: String
    // Кол-во углеводов
    var countCarbohydrate: String
    // Кол-во жиров
    var countFats: String
    // Кол-во белка
    var countProtein: String
}
