// StorageCategory.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные для коллекции
struct InfoCategory {
    // массив данных
    var categories: [Category] = [
        Category(
            sizeType: .medium,
            imageName: AppConstants.salad,
            categoryName: AppConstants.salad,
            hightTitle: 30,
            sizeText: 20, categoryType: .salad
        ),
        Category(
            sizeType: .medium,
            imageName: AppConstants.soup,
            categoryName: AppConstants.soup,
            hightTitle: 30,
            sizeText: 20, categoryType: .soup
        ),
        Category(
            sizeType: .large,
            imageName: AppConstants.chicken,
            categoryName: AppConstants.chicken,
            hightTitle: 50,
            sizeText: 20, categoryType: .chicken
        ),
        Category(
            sizeType: .small,
            imageName: AppConstants.meat,
            categoryName: AppConstants.meat,
            hightTitle: 28.6,
            sizeText: 16, categoryType: .meat
        ),
        Category(
            sizeType: .small,
            imageName: AppConstants.fish,
            categoryName: AppConstants.fish,
            hightTitle: 28.6,
            sizeText: 16, categoryType: .fish
        ),
        Category(
            sizeType: .small,
            imageName: AppConstants.sideDish,
            categoryName: AppConstants.sideDish,
            hightTitle: 28.6,
            sizeText: 16, categoryType: .sideDish
        ),
        Category(
            sizeType: .large,
            imageName: AppConstants.drinks,
            categoryName: AppConstants.drinks,
            hightTitle: 50,
            sizeText: 20, categoryType: .drinks
        ),
        Category(
            sizeType: .medium,
            imageName: AppConstants.pancake,
            categoryName: AppConstants.pancake,
            hightTitle: 30,
            sizeText: 20, categoryType: .pancake
        ),
        Category(
            sizeType: .medium,
            imageName: AppConstants.desserts,
            categoryName: AppConstants.desserts,
            hightTitle: 30,
            sizeText: 20, categoryType: .desserts
        )
    ]
}
