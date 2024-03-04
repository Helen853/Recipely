// StorageDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Массивы с подробными рецептами
struct RecipeDetail {
    /// Массив моделей ячеек с рецептом рыбы
    var fishDetail: [RecipeDetailProtocol] = [
        Image(
            title: AppConstants.foodName,
            imageName: AppConstants.foodImageName,
            massa: AppConstants.massaText,
            timeText: AppConstants.time
        ),
        InfoRecipe(
            countEnerc: AppConstants.numberEnerc,
            countCarbohydrate: AppConstants.numberCarbohydrate,
            countFats: AppConstants.numberFats,
            countProtein: AppConstants.numberProtein
        ),
        Text(recipe: AppConstants.recipeText)
    ]

    /// Массив моделей ячеек со вторым рецептом рыбы
    var secondFishDetail: [RecipeDetailProtocol] = [
        Image(
            title: AppConstants.fish,
            imageName: AppConstants.secondFish,
            massa: AppConstants.massaText,
            timeText: AppConstants.time
        ),
        InfoRecipe(
            countEnerc: AppConstants.numberEnerc,
            countCarbohydrate: AppConstants.numberCarbohydrate,
            countFats: AppConstants.numberFats,
            countProtein: AppConstants.numberProtein
        ),
        Text(recipe: AppConstants.recipeText)
    ]
}
