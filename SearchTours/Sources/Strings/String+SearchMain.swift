//
//  String+SearchMain.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

import Foundation

extension String {
    enum SearchMain {
        case searchMainNavTitle
        case searchTourButtonTitle
        case departureDateText(date: Date)
        case nightsCountText(count: Int)
        case adultsCount(count: Int)
        case kidsCount(count: Int)
        case countryDeparturePlaceholder
        case countryArrivalPlaceholder
        case departureDateTitle
        case nightCountTitle
        case personCountTitle
        case adultsCountText(count: Int)
        case kidsCountText(count: Int)
        case addAdultButtonTitle
        case addKidButtonTitle
        case ageKidTitle
        case addButtonTitle
        case doneButtonTitle
        
        var text: String {
            switch self {
            case .searchMainNavTitle:                                return "Поиск туров"
            case .searchTourButtonTitle:                             return "Найти тур"
            case .departureDateText(let date):                       return "\(date.dateDayAndMonthString)"
            case .nightsCountText(let count):
                let nightsCountStringFormat = NSLocalizedString("NIGHTS_COUNT", comment: "")
                return String.localizedStringWithFormat(nightsCountStringFormat, count)
            case .adultsCount(let count):
                let adultsCountStringFormat = NSLocalizedString("PERSONS_COUNT", comment: "")
                return String.localizedStringWithFormat(adultsCountStringFormat, count)
            case .kidsCount(let count):
                let kidsCountFormat = NSLocalizedString("KIDS_COUNT", comment: "")
                return " и \(String.localizedStringWithFormat(kidsCountFormat, count))"
            case .countryDeparturePlaceholder:                       return "Откуда"
            case .countryArrivalPlaceholder:                         return "Куда"
            case .departureDateTitle:                                return "Даты вылета"
            case .nightCountTitle:                                   return "Количество ночей"
            case .personCountTitle:                                  return "Кто едет"
            case .adultsCountText(let count):                        return "Взрослых: \(count)"
            case .kidsCountText(let count):                          return  "Детей: \(count)"
            case .addAdultButtonTitle:                               return "Добавить взрослого"
            case .addKidButtonTitle:                                 return "Добавить ребенка"
            case .ageKidTitle:                                       return "Возраст ребенка: "
            case .addButtonTitle:                                    return "Добавить"
            case .doneButtonTitle:                                   return "Готово"
            }
        }
    }
}

extension String {
    static func searchMain(_ item: SearchMain) -> String {
        return item.text
    }
}
