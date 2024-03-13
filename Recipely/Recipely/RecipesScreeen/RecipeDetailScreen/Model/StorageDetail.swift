// StorageDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Подробный рецепт
struct RecipeDetail {
    /// метод принимает модель с экрана рецептов и возвращает массив моделей для детального рецепта
    func setupDetail(model: Recipes) -> [RecipeDetailProtocol] {
        let details: [RecipeDetailProtocol] = [
            Image(
                title: model.foodName,
                imageName: model.imageFoodName,
                massa: AppConstants.massaText,
                timeText: String(model.foodTime) + AppConstants.time
            ),
            InfoRecipe(
                countEnerc: String(model.foodKkal),
                countCarbohydrate: AppConstants.numberCarbohydrate,
                countFats: AppConstants.numberFats,
                countProtein: AppConstants.numberProtein
            ),
            Text(recipe: AppConstants.recipeText)
        ]
        return details
    }
}
