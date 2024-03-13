// ImagesDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура с размером фотограыии
struct ImagesDTO: Codable {
    /// Размер фотографии
    let regular: LargeDTO

    /// Названия ключей
    enum CodingKeys: String, CodingKey {
        /// замена key regular
        case regular = "REGULAR"
    }
}
