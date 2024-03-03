// Image.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ячейка с картинкой рецепта
struct Image: RecipeDetailProtocol {
    // Тип ячейки
    var cellType: DetailType = .image
    // Название рецепта
    var title: String
    // Название картинки с рецептом
    var imageName: String
    // Масса блюда
    var massa: String
    // Время приготовления
    var timeText: String
}
