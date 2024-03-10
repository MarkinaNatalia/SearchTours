//
//  SearchPresenter.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

final class SearchPresenter {
    private let view: SearchViewInput
    private let router: SearchRouterInput
    private let interactor: SearchInteractorInput
    weak var moduleOutput: SearchModuleOutput?
    
    // MARK: Initialization
    
    init(view: SearchViewInput,
         router: SearchRouterInput,
         interactor: SearchInteractorInput) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func getTypeModule() -> SearchModuleType {
        return interactor.typeModule
    }
    
    @MainActor
    func loadData() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                if let cities = try await self.interactor.loadData() as? [DepartCityModel] {
                    view.loadedCities(cities)
                } else if let countries = try await self.interactor.loadData() as? [CountryModel] {
                    view.loadedCountries(countries)
                }
            } catch {
                
            }
        }
    }
    
    func selectedDepartCity(id: Int, name: String) {
        router.dismissModule() { [weak self] in
            guard let self = self else { return }
            self.moduleOutput?.selectedDepartCity(id: id, name: name)
        }
    }
    
    func selectedArrivalCountry(id: Int, name: String) {
        router.dismissModule() { [weak self] in
            guard let self = self else { return }
            self.moduleOutput?.selectedArrivalCountry(id: id, name: name)
        }
    }
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    
}
