// DataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

protocol DataServiceProtocol {
    func create(recipes: [Recipes], category: DishType)
    func fetch(category: DishType) -> [Recipes]
}

/// yewfuiwef
final class DataService: NSObject {
    private var coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension DataService: DataServiceProtocol {
    // создаю запись
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
            recipeCoreData.category = category.dishCategory

            coreDataManager.saveContext()
        }
    }

    // получааю запись
    func fetch(category: DishType) -> [Recipes] {
        let fetchReques = NSFetchRequest<RecipesCoreData>(entityName: "RecipesCoreData")
        do {
            let recipes = try? coreDataManager.context.fetch(fetchReques)
            guard let recipesOfCertainCategory = recipes?.filter({ $0.category == category.dishCategory })
            else { return [] }
            return recipesOfCertainCategory.map { Recipes(recipesCoreData: $0) }
        }
    }
}
