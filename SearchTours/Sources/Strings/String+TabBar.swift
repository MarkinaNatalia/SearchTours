//
//  String+TabBar.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

extension String {
    enum TabBar {
        case searchTitle
        case supportTitle
        case favoritesTitle
        case settingsTitle
        
        var text: String {
            switch self {
            case .searchTitle:       return "Поиск"
            case .supportTitle:      return "Помощь"
            case .favoritesTitle:    return "Избранное"
            case .settingsTitle:     return "Настройки"
            }
        }
    }
}

extension String {
    static func tabBar(_ item: TabBar) -> String {
        return item.text
    }
}
