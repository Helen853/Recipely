// StorageFavorites.swift
// Copyright © RoadMap. All rights reserved.

/// Хранилище сохраненный рецептов
struct StorageFavorites {
    var favoritesFood: [Recipes] = [
        .init(imageFoodName: "imageFood1", foodName: "Simple Fish And Corn", foodTime: "60", foodKkal: "274"),
        .init(
            imageFoodName: "imageFood2",
            foodName: "Basked Fish with Lemon Herb Sauce",
            foodTime: "90",
            foodKkal: "616"
        ),
        .init(imageFoodName: "imageFood3", foodName: "Lemon and Chilli Fish Burrito", foodTime: "60", foodKkal: "274"),
        .init(
            imageFoodName: "imageFood4",
            foodName: "Fast Roast Fish & Show Peas Recipes",
            foodTime: "90",
            foodKkal: "2226"
        ),
        .init(
            imageFoodName: "imageFood5",
            foodName: "Salmon with Cantaloupe and Fried Shallots",
            foodTime: "80",
            foodKkal: "94"
        )
    ]
}
