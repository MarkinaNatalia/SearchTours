//
//  Image+TabBar.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

import UIKit

extension UIImage {
    enum PngImage: String {
        case search          = "SearchIcon"
        case support         = "SupportIcon"
        case favorites       = "FavoritesIcon"
        case settings        = "SettingsItem"
        case peopleIcon      = "PeopleIcon"
        case starIcon        = "StarIcon"
        case backButton      = "BackButton"
    }
}

extension UIImage {
  static func pngImage(_ item: PngImage) -> UIImage? {
      return UIImage(named: item.rawValue)
  }
}
