//
//  ToursPresenter.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

final class ToursPresenter {
    private let view: ToursViewInput
    private let router: ToursRouterInput
    private let interactor: ToursInteractorInput
    
    // MARK: Initialization
    
    init(view: ToursViewInput,
         router: ToursRouterInput,
         interactor: ToursInteractorInput) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ToursViewOutput
//
extension ToursPresenter: ToursViewOutput {
    @MainActor
    func loadData(limit: Int, offset: Int) {
        Task {
            do {
                let searchResults = try await interactor.getSearchResults(limit: limit, offset: offset)
                view.loadedSearchResults(searchResults)
            } catch {
                
            }
        }
    }
    
    func getArrivalCountryName() -> String {
        return interactor.arrivalCountryName
    }
    
    func getDepartureDate() -> Date? {
        return interactor.departureDate
    }
    
    func getNightsCount() -> Int {
        return interactor.nightsCount
    }
    
    func getPersonsCount() -> Int {
        return interactor.personsCount
    }
}

// MARK: - ToursInteractorOutput

extension ToursPresenter: ToursInteractorOutput {
    
}
