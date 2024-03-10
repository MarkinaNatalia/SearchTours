//
//  ToursInteractorInput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

protocol ToursInteractorInput: AnyObject {
    var output: ToursInteractorOutput? { get set }
    var arrivalCountryName: String { get }
    var departureDate: Date? { get }
    var nightsCount: Int { get }
    var personsCount: Int { get }
    
    func getSearchResults(limit: Int, offset: Int) async throws -> SearchResultModel
}
