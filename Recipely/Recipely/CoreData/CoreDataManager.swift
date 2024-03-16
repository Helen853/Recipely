// CoreDataManager.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

final class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    override private init() {}

    lazy var context = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Data base URL - ", description.url?.absoluteString ?? "")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
