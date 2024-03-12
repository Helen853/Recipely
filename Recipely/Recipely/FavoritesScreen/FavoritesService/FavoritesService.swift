// FavoritesService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис FavoritesService
class FavoritesService {
    static let shared = FavoritesService()

    var favorites: [Recipes] = []

    func saveFavorites() {
        do {
            let encodedData = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encodedData, forKey: "favorites")
        } catch {
            print(error)
        }
    }

    func loadFavorites() -> [Recipes]? {
        guard let saved = UserDefaults.standard.data(forKey: "favorites") else { return [] }
        do {
            return try JSONDecoder().decode([Recipes].self, from: saved)
        } catch {
            print(error)
            return []
        }
    }

    func addFavorites(_ recipes: Recipes) {
        favorites.append(recipes)
        saveFavorites()
    }

    func removeFavorites(_ index: Int) {
        favorites.remove(at: index)
        saveFavorites()
    }

    func load() -> [Recipes] {
        guard let loadFavorites = loadFavorites() else { return [Recipes(
            imageFoodName: "",
            foodName: "",
            foodTime: 0,
            foodKkal: 0,
            isFavorites: false
        )] }
        favorites = loadFavorites
        return favorites
    }
}
