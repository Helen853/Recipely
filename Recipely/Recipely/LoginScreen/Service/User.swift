// User.swift
// Copyright © RoadMap. All rights reserved.

/// Модель пользователя
struct User: Codable {
    /// Почта
    var email: String
    /// Пароль
    var password: String
    /// Ник пользователя
    var surname: String
}
