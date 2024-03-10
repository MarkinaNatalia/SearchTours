//
//  SearchMainInteractorInput.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import Foundation

protocol SearchMainInteractorInput: AnyObject {
    var output: SearchMainInteractorOutput? { get set }
    
    func postSearch(departureDate: Date, nightsCount: Int, adultsCount: Int, kidsCount: Int, kidsAges: [Int]) async throws
    func setSelectedDepartCityId(_ id: Int)
    func setSelectedArrivalCountryId(_ id: Int)
}
