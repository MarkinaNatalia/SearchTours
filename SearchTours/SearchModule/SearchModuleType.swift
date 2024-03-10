//
//  SearchModuleType.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

enum SearchModuleType {
    case departureSearch
    case arrivalSearch
    
    var searchPlaceholderText: String {
        switch self {
        case .departureSearch:  return .search(.departureSearchPlaceholder)
        case .arrivalSearch:    return .search(.arrivalSearchPlaceholder)
        }
    }
}
