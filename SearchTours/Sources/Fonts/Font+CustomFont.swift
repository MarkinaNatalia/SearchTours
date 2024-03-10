//
//  Font+CustomFont.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

import UIKit

extension UIFont {
    enum CustomFont: String {
        case medium         = "Inter-Medium"
        case extraBold      = "Inter-ExtraBold"
        case semiBold       = "Inter-SemiBold"
    }
}

extension UIFont {
    static func customFont(_ item: CustomFont, size: CGFloat) -> UIFont? {
        return UIFont(name: item.rawValue, size: size)
    }
}
