//
//  SearchRouter.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

final class SearchRouter: SearchRouterInput {
    weak var viewController: UIViewController?
    
    func dismissModule(completion: @escaping () -> Void) {
        viewController?.dismiss(animated: true, completion: completion)
    }
}
