//
//  SearchMainRouterInput.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import Foundation

protocol SearchMainRouterInput: AnyObject {
    func openSearchModule(type: SearchModuleType, output: SearchModuleOutput?)
    func openToursModule(arrivalCountryName: String, departureDate: Date?, nightsCount: Int, personsCount: Int)
}
