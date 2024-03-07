// Command.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class LogCommand {
    let action: LogActions

    init(action: LogActions) { self.action = action
    }

    var log: String {
        switch action {
        case .openCategory:
            return "User open screen Category"
        case .openRecipe:
            return "User open screen Recipe"
        case .openRecipeDetail:
            return "User open screen Detail"
        case .shareRecipe:
            return "User share Recipe"
        }
    }
}
