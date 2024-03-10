//
//  SearchInteractorInput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

protocol SearchInteractorInput: AnyObject {
    var output: SearchInteractorOutput? { get set }
    var typeModule: SearchModuleType { get }
    
    func loadData() async throws -> [Any]
}
