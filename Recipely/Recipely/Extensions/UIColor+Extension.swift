// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для цветов во всем приложении
extension UIColor {
    /// Словарь с цветами
    static var colorStoreMap: [String: UIColor] = [:]
    /// Метод принимает параметры rgba и возвращает цвет
    class func rgb(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat
    ) -> UIColor {
        let key = "\(red)\(green)\(blue)"
        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor(
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            alpha: 1
        )
        colorStoreMap[key] = color
        return color
    }

    /// Серый цвет для заголовков
    static let grayForTitle = UIColor.rgb(71, 92, 102)
    /// Бирюзовый цвет
    static let turquoise = UIColor.rgb(112, 185, 190)
    /// Красный цвет для кнопки
    static let redForButton = UIColor.rgb(234, 101, 101)
    /// Серый цвет для фона
    static let grayForGround = UIColor.rgb(242, 245, 250)
    /// Серый цвет для текста
    static let grayForText = UIColor.rgb(151, 162, 176)
    /// Серый-прозрачный цвет
    static let grayOpasity = UIColor(red: 134 / 255, green: 139 / 255, blue: 145 / 255, alpha: 0.82)
    /// Бирюзовый-прозрачный цвет
    static let turquoiseOpasity = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 0.6)
}
