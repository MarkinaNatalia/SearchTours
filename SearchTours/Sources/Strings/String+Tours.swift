//
//  String+Tours.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

import Foundation

extension String {
    enum Tours {
        case navBarDescriptionText(date: Date, nights: Int, persons: Int)
        case departureDateTourTitle
        case arrivalDateTourTitle
        case nightsCountTourTitle
        case lineTitle
        case distanceBeachrTitle
        case freeWifiTitle
        case nightsCountValue(count: Int)
        case departureDateTitle(date: Date)
        case arrivalDateTitle(date: Date)
        case priceText(price: Int, adultsCount: Int, kidsCount: Int)
        
        var text: String {
            switch self {
            case let .navBarDescriptionText(date, nights, persons):         return "\(date.dateDayAndMonthTextString)・\(nights) ночей・\(persons) чел"
            case .departureDateTourTitle:                                   return "Туда "
            case .arrivalDateTourTitle:                                     return "・Обратно "
            case .nightsCountTourTitle:                                     return "・Ночей "
            case .lineTitle:                                                return "1 линия"
            case .distanceBeachrTitle:                                      return "200м до пляжа"
            case .freeWifiTitle:                                            return "Бесплатный Wi-Fi"
            case .nightsCountValue(let count):                              return "\(count)"
            case .departureDateTitle(let date):                             return "\(date.dateWithWeekdayString)"
            case .arrivalDateTitle(let date):                               return "\(date.dateWithWeekdayString)"
            case let .priceText(price, adultsCount, kidsCount):             return "от \(price) ₽ за \(adultsCount + kidsCount)-х"
            }
        }
    }
}

extension String {
    static func tours(_ item: Tours) -> String {
        return item.text
    }
}
