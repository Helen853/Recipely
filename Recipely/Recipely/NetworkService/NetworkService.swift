// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Протокол NetworkServiceProtocol
protocol NetworkServiceProtocol {
    /// Получение детального рецепта через JSON
    func getRecipesDetail(completion: @escaping (Result<Detalis, Error>) -> Void)
}

/// Сервис для получения данных
class NetworkService: NetworkServiceProtocol {
    func getRecipesDetail(completion: @escaping (Result<Detalis, Error>) -> Void) {
        guard let urlString =
            URL(
                string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=55feeb4f&app_key=474254b212c6eaa1e57af193e30de2ca&dishType=Soup"
            )
        else { return }

        URLSession.shared.dataTask(with: urlString) { data, _, error in
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
}
