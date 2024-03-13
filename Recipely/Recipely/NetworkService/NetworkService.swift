// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Протокол NetworkServiceProtocol
protocol NetworkServiceProtocol {
    /// Получение детального рецепта через JSON
    func getRecipesDetail(_ uri: String, completion: @escaping (Result<Detalis, Error>) -> Void)
  /// Получение рецепта через JSON
    func getRecipe(completion: @escaping (Result<Recipe, Error>) -> Void)
}

/// Сервис для получения данных
class NetworkService: NetworkServiceProtocol {
    var requestCreator = RequestCreator()

    func getRecipe(completion: @escaping (Result<Recipe, Error>) -> Void) {
        guard let request = requestCreator.createComponentsAllRecipes(.allRecipes) else { return }
        print(request)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let detail = try JSONDecoder().decode(RecipeResponseDTO.self, from: data)
                print(detail)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getRecipesDetail(_ uri: String, completion: @escaping (Result<Detalis, Error>) -> Void) {
        guard let request = requestCreator.createComponentsOneRecipes(uri, .oneRecipes) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let detail = try JSONDecoder().decode(RecipeDetailResponseDTO.self, from: data)
                print(detail)
            } catch {
                print(error)
            }
        }.resume()
    }
}
