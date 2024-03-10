//
//  TabBarItem.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

enum TabBarItem: Int {
    case search
    case support
    case favorites
    case settings
    
    var title: String {
        switch self {
        case .search:       return String.tabBar(.searchTitle)
        case .support:      return String.tabBar(.supportTitle)
        case .favorites:    return String.tabBar(.favoritesTitle)
        case .settings:     return String.tabBar(.settingsTitle)
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .search:       return .pngImage(.search)
        case .support:      return .pngImage(.support)
        case .favorites:    return .pngImage(.favorites)
        case .settings:     return .pngImage(.settings)
        }
    }
}
