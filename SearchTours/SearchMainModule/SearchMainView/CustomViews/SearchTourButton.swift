//
//  SearchTourButton.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

final class SearchTourButton: UIButton {
    let title: String
    
    // MARK: Initialization
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    
    private func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customColor(.orangeColor)
        layer.cornerRadius = 18
        
        let attributedText = NSAttributedString(string: title,
                                                attributes: [
                                                    NSAttributedString.Key.font: UIFont.customFont(.extraBold, size: 16),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white
                                                ]
        )
        setAttributedTitle(attributedText, for: .normal)
        
        heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}

