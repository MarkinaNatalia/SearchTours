//
//  BaseNetworkService.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

class BaseNetworkService<Router: URLRequestConvertible> {
    private let urlSession: URLSession
    private let decoder = JSONDecoder()
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    private func handleResponse(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    func request<T: Decodable>(_ returnType: T.Type, router: Router, parameters: [String: String]? = nil) async throws -> T {
        let request = try router.makeURLRequest(parameters: parameters)
        
        let (data, response) = try await urlSession.data(for: request)
        
        try handleResponse(response: response)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode(returnType, from: data)
            return decodedData
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
}
