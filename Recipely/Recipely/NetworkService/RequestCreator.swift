// RequestCreator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Перечилсение типов
enum DishType: String {
    /// Тип ячейки с салатами
    case salad
    /// Тип ячейки с садлатами
    case soup
    /// Тип ячейки с пирожными
    case pancake
    /// Тип ячейки с напитками
    case drinks
    /// Тип ячейки с десертами
    case desserts
    /// Тип ячейки с курицей, с мясом, с рыбой с sideDish
    case chicken, meat, fish, sideDish

    var dishCategory: String {
        switch self {
        case .chicken, .meat, .fish, .sideDish:
            return "Main Course"
        case .salad:
            return "salad"
        case .soup:
            return "soup"
        case .pancake:
            return "pancake"
        case .drinks:
            return "drinks"
        case .desserts:
            return "desserts"
        }
    }
}

/// Варианты path ссылки
enum PuthState: String {
    case allRecipes = "/api/recipes/v2"
    case oneRecipes = "/api/recipes/v2/by-uri"
}

/// Создание URL
class RequestCreator {
    private var components = URLComponents()

    func createComponentsAllRecipes(_ puthState: PuthState) -> URLRequest? {
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = puthState.rawValue
        components.queryItems = makeQueryItemsAllRecipes()
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }

    func createComponentsOneRecipes(_ uri: String, _ puthState: PuthState) -> URLRequest? {
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = puthState.rawValue
        components.queryItems = makeQueryItemsOneRecipes(uri)
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }

    func makeQueryItemsAllRecipesSearch() -> [URLQueryItem] {
        let typeQuery = URLQueryItem(name: "type", value: "public")
        let appIdQuery = URLQueryItem(name: "app_id", value: "55feeb4f")
        let appKeyQuery = URLQueryItem(name: "app_key", value: "474254b212c6eaa1e57af193e30de2ca")
        let dishTypeQuery = URLQueryItem(name: "dishType", value: DishType.meat.dishCategory)
        let quaryItem = URLQueryItem(name: "q", value: "zxc")
        let queries: [URLQueryItem] = [typeQuery, appIdQuery, appKeyQuery, dishTypeQuery, quaryItem]
        return queries
    }

    func makeQueryItemsAllRecipes() -> [URLQueryItem] {
        let typeQuery = URLQueryItem(name: "type", value: "public")
        let appIdQuery = URLQueryItem(name: "app_id", value: "55feeb4f")
        let appKeyQuery = URLQueryItem(name: "app_key", value: "474254b212c6eaa1e57af193e30de2ca")
        let dishTypeQuery = URLQueryItem(name: "dishType", value: DishType.sideDish.dishCategory)

        var queries: [URLQueryItem] = [typeQuery, appIdQuery, appKeyQuery, dishTypeQuery]

        if dishTypeQuery.value == DishType.sideDish.dishCategory {
            let healhtQuery = URLQueryItem(name: "health", value: "vegetarian")
            queries.append(healhtQuery)
        }
        return queries
    }

    func makeQueryItemsOneRecipes(_ uri: String) -> [URLQueryItem] {
        let typeQuery = URLQueryItem(name: "type", value: "public")
        let appIdQuery = URLQueryItem(name: "app_id", value: "55feeb4f")
        let appKeyQuery = URLQueryItem(name: "app_key", value: "474254b212c6eaa1e57af193e30de2ca")
        let byUri = URLQueryItem(name: "uri", value: uri)

        let queries: [URLQueryItem] = [typeQuery, appIdQuery, appKeyQuery, byUri]

        return queries
    }
}
