//
//  NetworkServiceProtocol.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

protocol NetworkServiceProtocol {
    func getDepartCities() async throws -> [DepartCityModel]
    func getCountries() async throws -> [CountryModel]
    func getRegions() async throws -> [RegionModel]
    func postSearch(departCityId: Int, countryId: Int, startFrom: String, startTo: String, durationFrom: Int, durationTo: Int, adults: Int, kids: Int, kidsAges: [Int]) async throws
    func getSearchResults(limit: Int, offset: Int) async throws -> SearchResultModel
}
