//
//  SearchMainInteractor.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import Foundation

final class SearchMainInteractor: SearchMainInteractorInput {
    weak var output: SearchMainInteractorOutput?
    
    let networkService = NetworkService.shared
    private var selectedDepartCityId: Int? = nil
    private var selectedArrivalCountryId: Int? = nil
    
    func postSearch(departureDate: Date,
                    nightsCount: Int,
                    adultsCount: Int,
                    kidsCount: Int,
                    kidsAges: [Int]) async throws {
        guard let departCityId = selectedDepartCityId,
              let countryId = selectedArrivalCountryId
        else { return }
        
        try await networkService.postSearch(departCityId: departCityId, 
                                            countryId: countryId,
                                            startFrom: departureDate.dateFullString,
                                            startTo: departureDate.dateFullString,
                                            durationFrom: nightsCount,
                                            durationTo: nightsCount,
                                            adults: adultsCount,
                                            kids: kidsCount,
                                            kidsAges: kidsAges)
    }
    
    func setSelectedDepartCityId(_ id: Int) {
        selectedDepartCityId = id
    }
    
    func setSelectedArrivalCountryId(_ id: Int) {
        selectedArrivalCountryId = id
    }
}
