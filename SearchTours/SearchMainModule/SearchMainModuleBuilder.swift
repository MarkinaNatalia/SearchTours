//
//  SearchMainModuleBuilder.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

final class SearchMainModuleBuilder {
    static func build() -> UIViewController {
        let view = SearchMainViewController()
        let router = SearchMainRouter()
        let interactor = SearchMainInteractor()
        let presenter = SearchMainPresenter(view: view,
                                            router: router,
                                            interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        router.viewController = view
        return view
    }
}
