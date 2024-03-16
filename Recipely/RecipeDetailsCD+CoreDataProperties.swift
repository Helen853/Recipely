// RecipeDetailsCD+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// erere
public extension RecipeDetailsCD {
    @nonobjc class func fetchRequest() -> NSFetchRequest<RecipeDetailsCD> {
        NSFetchRequest<RecipeDetailsCD>(entityName: "RecipeDetailsCD")
    }

    @NSManaged var calories: Double
    @NSManaged var chocdf: Double
    @NSManaged var fats: Double
    @NSManaged var images: String?
    @NSManaged var ingridientsLines: String?
    @NSManaged var label: String?
    @NSManaged var proteinn: Double
    @NSManaged var totalTime: Double
    @NSManaged var totalWeight: Double
}

extension RecipeDetailsCD: Identifiable {}
