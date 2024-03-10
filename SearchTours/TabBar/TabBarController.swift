//
//  TabBarController.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setApiKey()
    }
    
    // MARK: Private functions
    
    private func setupTabBar() {
        UITabBar.appearance().tintColor = .customColor(.orangeColor)
        
        let tabBarItems: [TabBarItem] = [.search, .support, .favorites, .settings]
        
        viewControllers = tabBarItems.map {
            switch $0 {
            case .search:   return createSearchMainModule()
            default:        
                let vc = UIViewController()
                vc.view.backgroundColor = .white
                return vc
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = tabBarItems[$0].title
            $1.tabBarItem.image = tabBarItems[$0].icon
        }
    }
    
    private func setApiKey() {
        let userDefaults = CustomUserDefaults.shared
        
        if !userDefaults.haveApiKey() {
            userDefaults.saveApiKey(key: "7f0185a09ec234cf0c2662a14d6e6fcf")
        }
    }
    
    private func createSearchMainModule() -> UIViewController {
        let viewController = SearchMainModuleBuilder.build()
        return UINavigationController(rootViewController: viewController)
    }
}
