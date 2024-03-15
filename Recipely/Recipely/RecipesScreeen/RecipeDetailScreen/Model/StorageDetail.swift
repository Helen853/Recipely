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
                imageName: model.images.regular.url,
                massa: String(Int(ceil(model.totalWeight))) + AppConstants.massaText,
                timeText: String(model.totalTime) + AppConstants.time
            ),
            InfoRecipe(
                countEnerc: String(Int(ceil(model.totalNutrients.calories.quantity))),
                countCarbohydrate: String(Int(ceil(model.totalNutrients.chocdf.quantity))),
                countFats: String(Int(ceil(model.totalNutrients.fat.quantity))),
                countProtein: String(Int(ceil(model.totalNutrients.protein.quantity)))
            ),
            Text(recipe: model.ingridientsLines)
        ]
        return details
    }
}
