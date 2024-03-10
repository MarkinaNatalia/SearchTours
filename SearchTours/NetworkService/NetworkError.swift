//
//  NetworkError.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
}
