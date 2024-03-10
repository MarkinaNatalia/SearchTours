//
//  DoneButton.swift
//  SearchTours
//
//  Created by Наталья on 10.03.2024.
//

import UIKit

final class DoneButton: UIButton {

    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    
    private func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customColor(.orangeColor)
        layer.cornerRadius = 5
        setTitle(.searchMain(.doneButtonTitle), for: .normal)
        
        heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}
