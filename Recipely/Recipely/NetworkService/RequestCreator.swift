// RequestCreator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

enum DishType: String {
    case salad
    case soup
    case chicken
    case meat
    case fish
    case sideDish
    case pancake
    case drinks
    case desserts
}

/// hebfuhfuie
class RequestCreator {
    private var components = URLComponents()
    let url: [URLComponents] = []

    func createComponents() -> [URLComponents] {
        components.scheme = "https"
        components.host = "api.edamam.com/api/recipes/v2"

        return []
    }

    func maekwQueryItems() -> [URLQueryItem] {
        let typeQuery = URLQueryItem(name: "type", value: "public")
        let appIdQuery = URLQueryItem(name: "app_id", value: "55feeb4f")
        let appKeyQuery = URLQueryItem(name: "app_key", value: "474254b212c6eaa1e57af193e30de2ca")
      let dishTypeQuery = URLQueryItem(name: "dishType", value: DishType.salad.rawValue)

        let queries: [URLQueryItem] = [typeQuery, appIdQuery, appKeyQuery, dishTypeQuery]

        return queries
    }
}
