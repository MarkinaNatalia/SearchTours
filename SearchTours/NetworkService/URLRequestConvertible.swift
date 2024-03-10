//
//  URLRequestConvertible.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest(parameters: [String: String]?) throws -> URLRequest
}
