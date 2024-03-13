// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол NetworkServiceProtocol
protocol NetworkServiceProtocol {
    /// Получение детального рецепта через JSON
    func getRecipesDetail(_ uri: String, completion: @escaping (Result<Detalis, Error>) -> Void)
    /// Получение рецепта через JSON
    func getRecipe(dishType: DishType, completion: @escaping (Result<[Recipes], Error>) -> Void)
}

/// Сервис для получения данных
final class NetworkService: NetworkServiceProtocol {
    private var requestCreator = RequestCreator()

    func getRecipe(dishType: DishType, completion: @escaping (Result<[Recipes], Error>) -> Void) {
        guard let request = requestCreator.makeComponentsAllRecipes(dishType: dishType, .allRecipes) else { return }
        print(request)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(RecipeResponseDTO.self, from: data)
                let res = result.hits.map { Recipes(dto: $0.recipe) }
                completion(.success(res))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getRecipesDetail(_ uri: String, completion: @escaping (Result<Detalis, Error>) -> Void) {
        guard let request = requestCreator.makeComponentsOneRecipes(uri, .oneRecipes) else { return }
        print(request)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            print(data)
            do {
                let result = try JSONDecoder().decode(RecipeDetailResponseDTO.self, from: data)
                guard let detaiDto = result.hits.first else { return }
                let detail = Detalis(dto: detaiDto)
                completion(.success(detail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
