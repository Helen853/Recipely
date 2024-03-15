// State.swift
// Copyright © RoadMap. All rights reserved.

/// Состояния загрузки ячеек
enum ViewState<Model> {
    /// Процесс загрузки
    case loading
    /// Загружено
    case data(_ model: Model)
    /// Нет данных
    case noData
    /// Ошибка
    case error
}
