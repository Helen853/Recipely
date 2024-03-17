// DataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

protocol DataServiceProtocol {
    func create(recipes: [Recipes], category: DishType)
    func fetch(category: DishType) -> [Recipes]
    func createRecipeDetail(details: Detalis)
}

/// yewfuiwef
final class DataService: NSObject {
    private var coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension DataService: DataServiceProtocol {
    // создаю запись рецептов экранов
    func create(recipes: [Recipes], category: DishType) {
        guard let recipeEntityDesription = NSEntityDescription.entity(
            forEntityName: "RecipesCoreData",
            in: coreDataManager.context
        ) else { return }
        for recipe in recipes {
            let recipeCoreData = RecipesCoreData(entity: recipeEntityDesription, insertInto: coreDataManager.context)
            recipeCoreData.foodKkal = recipe.foodKkal
            recipeCoreData.foodName = recipe.foodName
            recipeCoreData.foodTime = recipe.foodTime
            recipeCoreData.imageFoodName = recipe.imageFoodName
            recipeCoreData.uri = recipe.uri
            recipeCoreData.category = category.rawValue

            coreDataManager.saveContext()
        }
    }

    func createRecipeDetail(details: Detalis) {
        guard let recipeEntityDesription = NSEntityDescription.entity(
            forEntityName: "RecipeDetailsCD",
            in: coreDataManager.context
        ) else { return }
        let recipeDetails = RecipeDetailsCD(entity: recipeEntityDesription, insertInto: coreDataManager.context)
        recipeDetails.calories = details.calories
        recipeDetails.chocdf = details.chocdf
        recipeDetails.fats = details.fats
        recipeDetails.proteinn = details.proteins
        recipeDetails.images = details.images
        recipeDetails.ingridientsLines = details.ingridientsLines
        recipeDetails.label = details.label
        recipeDetails.totalTime = details.totalTime
        recipeDetails.totalWeight = details.totalWeight

        coreDataManager.saveContext()
    }

    func fetchDetails(uri: String) {
        let fetchReques = RecipesCoreData.fetchRequest()
        do {
            let details = try? coreDataManager.context.fetch(fetchReques)
        }
    }

    // получааю запись рецептов
    func fetch(category: DishType) -> [Recipes] {
        let fetchReques = RecipesCoreData.fetchRequest()
        do {
            let recipes = try? coreDataManager.context.fetch(fetchReques)
            guard let recipesOfCertainCategory = recipes?.filter({ $0.category == category.rawValue })
            else { return [] }
            return recipesOfCertainCategory.map { Recipes(recipesCoreData: $0) }
        }
    }
}
