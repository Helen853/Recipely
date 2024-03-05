// Recipes.swift
// Copyright © RoadMap. All rights reserved.

// Ячейка еды
struct Recipes {
    // Каартинка еды
    var imageFoodName: String
    // Название еды
    var foodName: String
    // Время готовки еды
    var foodTime: Int
    // Калории
    var foodKkal: Int
}

/// Состояния кнопок
enum SortingState {
    // Кнопка не нажата
    case none
    // Сортировка по возрастанию
    case up
    // Сортировка по убыванию
    case down
}
