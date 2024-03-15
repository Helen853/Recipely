// ProxyServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Потокол для сервиса загрузки фото
protocol LoadServiceProtocol {
    /// Метод загрузки фотографии
    func loadImage(url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ())
}
