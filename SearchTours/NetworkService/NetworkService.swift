//
//  NetworkService.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

final class NetworkService: BaseNetworkService<EventRouter>, NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private var keySearch: String?
    
    func getDepartCities() async throws -> [DepartCityModel] {
        return try await request([DepartCityModel].self, router: .getDepartCities)
    }
    
    func getCountries() async throws -> [CountryModel] {
        return try await request([CountryModel].self, router: .getCountries)
    }
    
    func getRegions() async throws -> [RegionModel] {
        return try await request([RegionModel].self, router: .getRegions)
    }
    
    func postSearch(departCityId: Int, countryId: Int, startFrom: String, startTo: String, durationFrom: Int, durationTo: Int, adults: Int, kids: Int, kidsAges: [Int]) async throws {
        let parameters: [String: String] = [
            "search[depart_city_id]": "\(departCityId)",
            "search[region_ids][]": "\(countryId)",
            "search[start_from]": "\(startFrom)",
            "search[start_to]": "\(startTo)",
            "search[duration_from]": "\(durationFrom)",
            "search[duration_to]": "\(durationTo)",
            "search[adults]": "\(adults)",
            "search[kids]": "\(kids)",
            "search[kids_ages]": "\(kidsAges)"
        ]
        
        let resultModel = try await request(ResultPostSearchModel.self, router: .postSearch, parameters: parameters)
        
        keySearch = resultModel.key
    }
    
    func getSearchResults(limit: Int, offset: Int) async throws -> SearchResultModel {
        return try await request(SearchResultModel.self, router: .getSearchResults(key: keySearch ?? "", limit: limit, offset: offset))
    }
}
