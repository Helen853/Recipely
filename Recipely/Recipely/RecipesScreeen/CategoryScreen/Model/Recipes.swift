// Recipes.swift
// Copyright © RoadMap. All rights reserved.

// Ячейка еды
struct RecipesV2: Equatable, Codable {
    // Картинка еды
    var imageFoodName: String
    // Название еды
    var foodName: String
    // Время готовки еды
    var foodTime: Int
    // Калории
    var foodKkal: Int
}

/// Сортировка по калорием
enum SortedCalories {
    /// Обычное состояние
    case non
    /// Состояние в меньшую сторону
    case caloriesLow
    /// Состояние в большое сторону
    case caloriesHigh
}

/// Сортировка по времени
enum SortedTime {
    /// Обчное состояние
    case non
    /// Состояние в меньшую сторону
    case timeLow
    /// Состояние в большую сторону
    case timeHigh
}
