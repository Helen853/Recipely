// StorageDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Подробный рецепт
struct RecipeDetail {
    /// метод принимает модель деталей и возвращает массив моделей для детального рецепта
    func setupDetail(model: Detalis) -> [RecipeDetailProtocol] {
        let details: [RecipeDetailProtocol] = [
            Image(
                title: model.label,
                imageName: model.images,
                massa: String(Int(ceil(model.totalWeight))) + AppConstants.massaText,
                timeText: String(model.totalTime) + AppConstants.time
            ),
            InfoRecipe(
                countEnerc: String(Int(ceil(model.calories))),
                countCarbohydrate: String(Int(ceil(model.chocdf))),
                countFats: String(Int(ceil(model.fats))),
                countProtein: String(Int(ceil(model.proteins)))
            ),
            Text(recipe: model.ingridientsLines.components(separatedBy: "\n"))
        ]
        return details
    }
}
