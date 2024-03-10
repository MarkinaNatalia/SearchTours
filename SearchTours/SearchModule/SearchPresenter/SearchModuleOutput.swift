//
//  SearchModuleOutput.swift
//  SearchTours
//
//  Created by Наталья on 06.03.2024.
//

protocol SearchModuleOutput: AnyObject {
    func selectedDepartCity(id: Int, name: String)
    func selectedArrivalCountry(id: Int, name: String)
}
