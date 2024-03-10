//
//  String+Search.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

extension String {
    enum Search {
        case departureSearchPlaceholder
        case arrivalSearchPlaceholder
        case searchBackButtonTitle
        
        var text: String {
            switch self {
            case .departureSearchPlaceholder:      return "Город вылета"
            case .arrivalSearchPlaceholder:        return "Страна, курорт, отель"
            case .searchBackButtonTitle:           return "Закрыть"
            }
        }
    }
}

extension String {
    static func search(_ item: Search) -> String {
        return item.text
    }
}
