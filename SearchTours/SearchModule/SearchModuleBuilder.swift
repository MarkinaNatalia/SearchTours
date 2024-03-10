//
//  SearchModuleBuilder.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

final class SearchModuleBuilder {
    static func build(type: SearchModuleType, output: SearchModuleOutput?) -> UIViewController {
        let view = SearchViewController()
        let router = SearchRouter()
        let interactor = SearchInteractor(type: type)
        let presenter = SearchPresenter(view: view,
                                        router: router,
                                        interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        router.viewController = view
        presenter.moduleOutput = output
        return view
    }
}
