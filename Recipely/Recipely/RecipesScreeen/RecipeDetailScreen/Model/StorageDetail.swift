// StorageDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Массивы с подробными рецептами
struct RecipeDetail {
//    Массив моделей ячеек с рецептом рыбы
//    var fishDetail: [RecipeDetailProtocol] = [
//        Image(
//          title: AppConstants.foodName,
//            imageName: AppConstants.foodImageName,
//            massa: AppConstants.massaText,
//            timeText: AppConstants.time
//        ),
//        InfoRecipe(
//            countEnerc: AppConstants.numberEnerc,
//            countCarbohydrate: AppConstants.numberCarbohydrate,
//            countFats: AppConstants.numberFats,
//            countProtein: AppConstants.numberProtein
//        ),
//        Text(recipe: AppConstants.recipeText)
//    ]

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

//    Массив моделей ячеек со вторым рецептом рыбы
//    var secondFishDetail: [RecipeDetailProtocol] = [
//        Image(
//            title: "Basked Fish with Lemon Herb Sauce",
//            imageName: AppConstants.secondFish,
//            massa: AppConstants.massaText,
//            timeText: AppConstants.time
//        ),
//        InfoRecipe(
//            countEnerc: AppConstants.numberEnerc,
//            countCarbohydrate: AppConstants.numberCarbohydrate,
//            countFats: AppConstants.numberFats,
//            countProtein: AppConstants.numberProtein
//        ),
//        Text(recipe: AppConstants.recipeText)
//    ]
}
