//
//  SearchTableViewCell.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

final class SearchTableViewCell : UITableViewCell {
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, 
                   reuseIdentifier: reuseIdentifier)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Reuse cell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
    }
    
    // MARK: Updating data
    
    func updateData(title: String) {
        textLabel?.text = title
    }
    
    // MARK: Private functions
    
    private func setupSettings() {
        textLabel?.textColor = .customColor(.darkGreenColor)
        textLabel?.font = .customFont(.semiBold, size: 16)
        selectionStyle = .none
    }
}
