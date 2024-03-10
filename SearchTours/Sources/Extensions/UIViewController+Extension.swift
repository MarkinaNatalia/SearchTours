//
//  UIViewController+Extension.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

extension UIViewController {
    func createNavigationBarWithTwoLabel(title: String?, description: String?) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .customColor(.nameHotelColor)
        titleLabel.font = .customFont(.semiBold, size: 16)
        
        let titleDescription = UILabel()
        titleDescription.text = description
        titleDescription.textColor = .customColor(.grayColor)
        titleDescription.font = .customFont(.medium, size: 12)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleDescription])
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        
        navigationItem.titleView = stackView
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setNavigationBackButton() {
        navigationItem.setHidesBackButton(true, animated:false)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        button.setImage(.pngImage(.backButton), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view ?? UIView())
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
