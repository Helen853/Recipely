// StorageDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Подробный рецепт
struct RecipeDetail {
    /// метод принимает модель с экрана рецептов и возвращает массив моделей для детального рецепта
    func setupDetail(model: Detalis) -> [RecipeDetailProtocol] {
        let details: [RecipeDetailProtocol] = [
            Image(
                title: model.label,
                imageName: model.images.regular.url,
                massa: String(model.totalWeight),
                timeText: String(model.totalTime) + AppConstants.time
            ),
            InfoRecipe(
                countEnerc: String(model.totalNutrients.calories.quantity),
                countCarbohydrate: String(model.totalNutrients.chocdf.quantity),
                countFats: String(model.totalNutrients.fat.quantity),
                countProtein: String(model.totalNutrients.protein.quantity)
            ),
            Text(recipe: model.ingridientsLines)
        ]
        return details
    }
}
