//
//  SearchRouterInput.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

protocol SearchRouterInput: AnyObject {
    func dismissModule(completion: @escaping () -> Void)
}
