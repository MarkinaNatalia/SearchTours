//
//  EventRouter.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

enum EventRouter: URLRequestConvertible {
    case getDepartCities
    case getCountries
    case getRegions
    case postSearch
    case getSearchResults(key: String, limit: Int, offset: Int)
    
    var endpointUrl: String {
        switch self {
        case .getDepartCities:                             return "/depart_cities"
        case .getCountries:                                return "/countries"
        case .getRegions:                                  return "/regions"
        case .postSearch:                                  return "/searches"
        case let .getSearchResults(key, limit, offset):    return "/searches/\(key)/results?limit=\(limit)&offset=\(offset)"
        }
    }
    
    var method: String {
        switch self {
        case .postSearch:   return "POST"
        default:            return "GET"
        }
    }
    
    func makeURLRequest(parameters: [String: String]? = nil) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: APIConfig.baseUrl + endpointUrl) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let headers = [
            "Authorization": "Token token=\(CustomUserDefaults.shared.getApiKey())",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
