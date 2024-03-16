// RecipesCoreData+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// ueygfeu
public extension RecipesCoreData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<RecipesCoreData> {
        NSFetchRequest<RecipesCoreData>(entityName: "RecipesCoreData")
    }

    @NSManaged var imageFoodName: String?
    @NSManaged var foodName: String?
    @NSManaged var foodTime: Double
    @NSManaged var foodKkal: Double
    @NSManaged var uri: String?
    @NSManaged var category: String?
}

extension RecipesCoreData: Identifiable {}
