//
//  SearchViewOutput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

protocol SearchViewOutput: AnyObject {
    func getTypeModule() -> SearchModuleType
    func loadData()
    func selectedDepartCity(id: Int, name: String)
    func selectedArrivalCountry(id: Int, name: String)
}
