//
//  SearchMainViewOutput.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import Foundation

protocol SearchMainViewOutput: AnyObject {
    func openSearch(type: SearchModuleType)
    func searchTourButtonAction(departureDate: Date, nightsCount: Int, adultsCount: Int, kidsCount: Int, kidsAges: [Int])
}
