// Recipes.swift
// Copyright © RoadMap. All rights reserved.

// Ячейка еды
struct Recipes {
    // Каартинка еды
    var imageFoodName: String
    // Название еды
    var foodName: String
    // Время готовки еды
    var foodTime: String
    // Калории
    var foodKkal: String
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
