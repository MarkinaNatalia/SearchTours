//
//  SearchViewInput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

protocol SearchViewInput: AnyObject {
    var output: SearchViewOutput? { get set }
    
    func loadedCities(_ cities: [DepartCityModel])
    func loadedCountries(_ countries: [CountryModel])
}
