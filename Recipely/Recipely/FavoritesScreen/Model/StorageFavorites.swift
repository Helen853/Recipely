// StorageFavorites.swift
// Copyright © RoadMap. All rights reserved.

/// Хранилище сохраненных рецептов
struct StorageFavorites {
    var favoritesFood: [Recipes] = [
        .init(
            imageFoodName: "imageFood1",
            foodName: "Simple Fish And Corn",
            foodTime: 60,
            foodKkal: 274,
            isFavorites: false
        ),
        .init(
            imageFoodName: "imageFood2",
            foodName: "Basked Fish with Lemon Herb Sauce",
            foodTime: 90,
            foodKkal: 616, isFavorites: false
        ),
        .init(
            imageFoodName: "imageFood3",
            foodName: "Lemon and Chilli Fish Burrito",
            foodTime: 60,
            foodKkal: 274,
            isFavorites: false
        ),
        .init(
            imageFoodName: "imageFood4",
            foodName: "Fast Roast Fish & Show Peas Recipes",
            foodTime: 90,
            foodKkal: 2226, isFavorites: false
        ),
        .init(
            imageFoodName: "imageFood5",
            foodName: "Salmon with Cantaloupe and Fried Shallots",
            foodTime: 80,
            foodKkal: 94, isFavorites: false
        )
    ]
}
