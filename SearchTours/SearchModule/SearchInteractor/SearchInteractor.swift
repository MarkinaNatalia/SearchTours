//
//  SearchInteractor.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

final class SearchInteractor: SearchInteractorInput {
    weak var output: SearchInteractorOutput?
    
    var typeModule: SearchModuleType
    private let networkService = NetworkService.shared
    
    init(type: SearchModuleType) {
        typeModule = type
    }
    
    func loadData() async throws -> [Any] {
        switch typeModule {
        case .departureSearch:
            return try await networkService.getDepartCities()
        case .arrivalSearch:
            return try await networkService.getCountries()
        }
    }
}
