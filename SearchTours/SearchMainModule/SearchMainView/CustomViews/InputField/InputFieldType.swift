//
//  InputFieldType.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

enum InputFieldType {
    case countryDeparture
    case countryArrival
    case departureDate
    case nightCount
    case personCount
    
    var placeholderText: String {
        switch self {
        case .countryDeparture:   return .searchMain(.countryDeparturePlaceholder)
        case .countryArrival:     return .searchMain(.countryArrivalPlaceholder)
        case .departureDate:      return .searchMain(.departureDateTitle).uppercased()
        case .nightCount:         return .searchMain(.nightCountTitle).uppercased()
        case .personCount:        return .searchMain(.personCountTitle).uppercased()
        }
    }
    
    var maskedCorners: CACornerMask {
        switch self {
        case .countryDeparture:   return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .countryArrival:     return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .departureDate:      return [.layerMinXMinYCorner]
        case .nightCount:         return [.layerMaxXMinYCorner]
        case .personCount:        return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}
