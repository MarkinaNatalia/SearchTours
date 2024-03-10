//
//  ToursModuleBuilder.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

final class ToursModuleBuilder {
    
    static func build(arrivalCountryName: String, departureDate: Date?, nightsCount: Int, personsCount: Int) -> UIViewController {
        let view = ToursViewController()
        let router = ToursRouter()
        let interactor = ToursInteractor(arrivalCountryName: arrivalCountryName,
                                         departureDate: departureDate,
                                         nightsCount: nightsCount,
                                         personsCount: personsCount)
        let presenter = ToursPresenter(view: view,
                                       router: router,
                                       interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        router.viewController = view
        return view
    }
}
