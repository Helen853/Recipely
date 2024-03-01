// Array+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для безопасного доступа к массиву ячеек с моделями на экране профиль
extension Array {
    subscript(safe index: Int) -> Element? {
        index > count - 1 ? self[index] : nil
    }
}
