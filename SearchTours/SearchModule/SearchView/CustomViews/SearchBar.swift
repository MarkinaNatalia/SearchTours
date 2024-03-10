//
//  SearchBar.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

class SearchBar: UISearchBar {
    let typeModule: SearchModuleType
    
    // MARK: Initialization
    
    init(typeModule: SearchModuleType) {
        self.typeModule = typeModule
        
        super.init(frame: .zero)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup settings
    
    private func setupSettings() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = .search(.searchBackButtonTitle)
        translatesAutoresizingMaskIntoConstraints = false
        searchBarStyle = .minimal
        placeholder = typeModule.searchPlaceholderText
        tintColor = .customColor(.blueColor)
        isTranslucent = true
        setImage(UIImage(), for: .search, state: .normal)
    }
}
