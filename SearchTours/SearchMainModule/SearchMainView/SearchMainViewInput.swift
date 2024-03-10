//
//  SearchMainViewInput.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

protocol SearchMainViewInput: AnyObject {
    var output: SearchMainViewOutput? { get set }
    
    func updateCountryDepartureText(name: String)
    func updateCountryArrivalText(name: String)
}
