//
//  Date+Extension.swift
//  SearchTours
//
//  Created by Наталья on 10.03.2024.
//

import Foundation

extension Date {
    var dateDayAndMonthString: String {
        let formatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID ?? "")
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: self)
    }
    
    var dateWithWeekdayString: String {
        let formatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID ?? "")
        formatter.dateFormat = "dd.MM E"
        return formatter.string(from: self)
    }
    
    var dateFullString: String {
        let formatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID ?? "")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    var dateDayAndMonthTextString: String {
        let formatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID ?? "")
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self)
    }
}
