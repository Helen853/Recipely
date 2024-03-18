// DataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

protocol DataServiceProtocol {
    /// Создание записи рецептов
    func create(recipes: [Recipes], category: DishType)
    /// получить запись рецептов
    func fetch(category: DishType) -> [Recipes]
    /// создать запись детальных рецептов
    func createRecipeDetail(details: Detalis)
    /// получить запись детальных рецептов
    func fetchDetails(recipes: Recipes?) -> Detalis?
}

/// Data Service для записи и получения записей о рецептах и детальных рецептах
final class DataService: NSObject {
  // MARK: - Constants
  private enum Constants {
    static let forEntityNameRecipes = "RecipesCoreData"
    static let forEntityNameRecipesDetails = "RecipeDetailsCD"
  }
    private var coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

/// DataService + DataServiceProtocol
extension DataService: DataServiceProtocol {
    // создаю запись рецептов экранов
    func create(recipes: [Recipes], category: DishType) {
        guard let recipeEntityDesription = NSEntityDescription.entity(
          forEntityName: Constants.forEntityNameRecipes,
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
        guard let recipeDetailEntityDesription = NSEntityDescription.entity(
          forEntityName: Constants.forEntityNameRecipesDetails,
            in: coreDataManager.context
        ) else { return }
        let recipeDetails = RecipeDetailsCD(entity: recipeDetailEntityDesription, insertInto: coreDataManager.context)
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

    func fetchDetails(recipes: Recipes?) -> Detalis? {
        let fetchRequest = RecipeDetailsCD.fetchRequest()
        do {
            let details = try? coreDataManager.context.fetch(fetchRequest)
            guard let recipeDetail = details else { return nil }
            for recipe in recipeDetail where recipe.label == recipes?.foodName {
                return Detalis(recipeDetailsCD: recipe)
            }
            return nil
        }
    }

    // получааю запись рецептов
    func fetch(category: DishType) -> [Recipes] {
        let fetchRequest = RecipesCoreData.fetchRequest()
        do {
            let recipes = try? coreDataManager.context.fetch(fetchRequest)
            guard let recipesOfCertainCategory = recipes?.filter({ $0.category == category.rawValue })
            else { return [] }
            return recipesOfCertainCategory.map { Recipes(recipesCoreData: $0) }
        }
    }
}
