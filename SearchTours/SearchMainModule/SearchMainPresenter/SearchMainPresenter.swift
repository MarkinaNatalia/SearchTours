//
//  SearchMainPresenter.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import Foundation

final class SearchMainPresenter {
    private let view: SearchMainViewInput
    private let router: SearchMainRouterInput
    private let interactor: SearchMainInteractorInput
    
    private var selectedArrivalCountryName: String = ""
    
    // MARK: Initialization
    
    init(view: SearchMainViewInput, 
         router: SearchMainRouterInput,
         interactor: SearchMainInteractorInput) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SearchMainViewOutput

extension SearchMainPresenter: SearchMainViewOutput {
    func openSearch(type: SearchModuleType) {
        router.openSearchModule(type: type, output: self)
    }
    
    @MainActor
    func searchTourButtonAction(departureDate: Date,
                                nightsCount: Int,
                                adultsCount: Int,
                                kidsCount: Int,
                                kidsAges: [Int]) {
        Task {
            do {
                try await interactor.postSearch(departureDate: departureDate,
                                                nightsCount: nightsCount,
                                                adultsCount: adultsCount,
                                                kidsCount: kidsCount,
                                                kidsAges: kidsAges)
                router.openToursModule(arrivalCountryName: selectedArrivalCountryName,
                                       departureDate: departureDate,
                                       nightsCount: nightsCount,
                                       personsCount: adultsCount + kidsCount)
            } catch {
                
            }
        }
    }
}

// MARK: - SearchMainInteractorOutput

extension SearchMainPresenter: SearchMainInteractorOutput {
    
}

// MARK: - SearchModuleOutput

extension SearchMainPresenter: SearchModuleOutput {
    func selectedDepartCity(id: Int, name: String) {
        interactor.setSelectedDepartCityId(id)
        view.updateCountryDepartureText(name: name)
    }
    
    func selectedArrivalCountry(id: Int, name: String) {
        self.selectedArrivalCountryName = name
        interactor.setSelectedArrivalCountryId(id)
        view.updateCountryArrivalText(name: name)
    }
}
