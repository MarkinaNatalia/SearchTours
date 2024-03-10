//
//  ToursViewInput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

protocol ToursViewInput: AnyObject {
    var output: ToursViewOutput? { get set }
    
    func loadedSearchResults(_ searchResults: SearchResultModel)
}
