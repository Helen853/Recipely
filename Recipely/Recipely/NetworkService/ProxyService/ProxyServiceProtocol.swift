// ProxyServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// потокол для сервиса загрузки фото
protocol LoadServiceProtocol {
    func loadImage(url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ())
}
