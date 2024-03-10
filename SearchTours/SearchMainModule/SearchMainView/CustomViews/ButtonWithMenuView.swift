//
//  ButtonWithMenuView.swift
//  SearchTours
//
//  Created by Наталья on 10.03.2024.
//

import UIKit

final class ButtonWithMenuView: UIButton {
    private let elements: [UIMenuElement]

    // MARK: Initialization
    
    init(elements: [UIMenuElement]) {
        self.elements = elements
        
        super.init(frame: .zero)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    
    private func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.customColor(.blackColor), for: .normal)
        menu = UIMenu(options: .singleSelection, children: elements)
        showsMenuAsPrimaryAction = true
        changesSelectionAsPrimaryAction = true
    }
}
