//
//  SearchMainRouter.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

final class SearchMainRouter: SearchMainRouterInput {
    weak var viewController: UIViewController?
    
    func openSearchModule(type: SearchModuleType, output: SearchModuleOutput?) {
        let searchVC = SearchModuleBuilder.build(type: type, output: output)
        viewController?.present(searchVC, animated: true)
    }
    
    func openToursModule(arrivalCountryName: String, departureDate: Date?, nightsCount: Int, personsCount: Int) {
        let toursVC = ToursModuleBuilder.build(arrivalCountryName: arrivalCountryName,
                                               departureDate: departureDate,
                                               nightsCount: nightsCount,
                                               personsCount: personsCount)
        viewController?.navigationController?.pushViewController(toursVC, animated: true)
    }
}
