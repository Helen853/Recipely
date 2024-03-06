// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для цветов во всем приложении
extension UIColor {
    static var colorStoreMap: [String: UIColor] = [:]

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

    static var grayForTitle = UIColor.rgb(71, 92, 102)
    static var turquoise = UIColor.rgb(112, 185, 190)
    static var redForButton = UIColor.rgb(234, 101, 101)
    static var grayForGround = UIColor.rgb(242, 245, 250)
    static var grayForText = UIColor.rgb(151, 162, 176)

    static var grayOpasity = UIColor(red: 134 / 255, green: 139 / 255, blue: 145 / 255, alpha: 0.82)
    static var turquoiseOpasity = UIColor(red: 112 / 255, green: 185 / 255, blue: 190 / 255, alpha: 0.6)
}
