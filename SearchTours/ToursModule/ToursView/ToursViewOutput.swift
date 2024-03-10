//
//  ToursViewOutput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

protocol ToursViewOutput: AnyObject {
    func loadData(limit: Int, offset: Int)
    func getArrivalCountryName() -> String
    func getDepartureDate() -> Date?
    func getNightsCount() -> Int
    func getPersonsCount() -> Int
}
