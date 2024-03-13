// Command.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Command
final class LogCommand {
    private let action: LogActions

    init(action: LogActions) { self.action = action
    }

    var log: String {
        switch action {
        case .openCategory:
            return AppConstants.openCategoryText
        case .openRecipe:
            return AppConstants.openRecipeText
        case .openRecipeDetail:
            return AppConstants.openRecipeDetailText
        case .shareRecipe:
            return AppConstants.shareRecipeText
        }
    }
}
