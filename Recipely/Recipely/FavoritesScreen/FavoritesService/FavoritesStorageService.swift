// FavoritesStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис сохранения и удаления из избранного
final class FavoritesStorageService {
    // MARK: - Constsnts

    private enum Constants {
        static let favoritesKey = "favorites"
    }

    static let shared = FavoritesStorageService()

    // MARK: - Public Properties

    var favorites: [Recipes] = []

    // MARK: - Public Methods

    func loadFavorites() -> [Recipes]? {
        guard let saved = UserDefaults.standard.data(forKey: Constants.favoritesKey) else { return [] }
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
        guard let loadFavorites = loadFavorites() else { return [Recipes(dto: RecipeDTO(
            image: "",
            label: "",
            totalTime: 0,
            calories: 0,
            uri: ""
        ))] }
        favorites = loadFavorites
        return favorites
    }

    // MARK: - Private Methods

    private func saveFavorites() {
        do {
            let encodedData = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encodedData, forKey: Constants.favoritesKey)
        } catch {
            print(error)
        }
    }
}
