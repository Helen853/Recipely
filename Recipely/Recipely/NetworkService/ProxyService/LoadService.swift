// LoadService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис загрузки фото
final class LoadImageSErvice: LoadServiceProtocol {
    /// Метод закгрузки фотографии
    func loadImage(url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let sessin = URLSession(configuration: config)
        sessin.dataTask(with: url, completionHandler: complition).resume()
    }
}
