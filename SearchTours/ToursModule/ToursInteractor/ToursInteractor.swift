//
//  ToursInteractor.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

final class ToursInteractor: ToursInteractorInput {
    weak var output: ToursInteractorOutput?
    
    private let networkService = NetworkService.shared
    var arrivalCountryName: String
    var departureDate: Date?
    var nightsCount: Int
    var personsCount: Int
    
    init(arrivalCountryName: String, departureDate: Date?, nightsCount: Int, personsCount: Int) {
        self.arrivalCountryName = arrivalCountryName
        self.departureDate = departureDate
        self.nightsCount = nightsCount
        self.personsCount = personsCount
    }
    
    func getSearchResults(limit: Int, offset: Int) async throws -> SearchResultModel {
        return try await networkService.getSearchResults(limit: limit, 
                                                         offset: offset)
    }
}
