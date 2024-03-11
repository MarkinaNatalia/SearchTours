//
//  InputField.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

protocol InputFieldDelegate {
    func openSearch(type: SearchModuleType)
}

final class InputField: UIView {
    private var type: InputFieldType = .countryDeparture
    private var customInputView: UIView?
    private var delegateView: InputFieldDelegate?
    
    // MARK: UI components
    
    private lazy var placeholderLabel    = createPlaceholderLabel()
    private lazy var textField           = createTextField()
    private lazy var stackView           = createStackView()
    
    // MARK: Initialization
    
    init(type: InputFieldType, 
         customInputView: UIView? = nil,
         delegateView: InputFieldDelegate?) {
        self.type = type
        self.customInputView = customInputView
        self.delegateView = delegateView
        
        super.init(frame: .zero)
        setupSettings()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Updating data
    
    func updateText(_ text: String) {
        textField.text = text
    }
    
    func isEmpty() -> Bool {
        guard let text = textField.text else { return true }
        return text.isEmpty
    }
    
    // MARK: Setup settings
    
    private func setupSettings() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customColor(.lightGrayColor)
        layer.cornerRadius = 16
        layer.maskedCorners = type.maskedCorners
        layer.masksToBounds = true
    }
    
    // MARK: Private functions
    
    private func addSubviews() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: Creating UI components
    
    private func createPlaceholderLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = type.placeholderText
        label.textColor = .customColor(.grayColor)
        label.font = .customFont(.medium, size: 16)
        
        switch type {
        case .countryDeparture: label.isHidden = true
        case .countryArrival: label.isHidden = true
        default: label.isHidden = false
        }
        
        return label
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .customColor(.blackColor)
        textField.font = .customFont(.medium, size: 16)
        textField.delegate = self
        textField.inputView = customInputView
        
        if type == .countryArrival || type == .countryDeparture {
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.customColor(.grayColor),
                NSAttributedString.Key.font: UIFont.customFont(.medium, size: 16)
            ]
            textField.attributedPlaceholder = NSAttributedString(string: type.placeholderText,
                                                                 attributes: attributes)
        }
        
        return textField
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        
        stackView.addArrangedSubview(placeholderLabel)
        stackView.addArrangedSubview(textField)
        return stackView
    }
}

// MARK: - UITextFieldDelegate

extension InputField: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch type {
        case .countryDeparture:
            delegateView?.openSearch(type: .departureSearch)
            return false
        case .countryArrival:
            delegateView?.openSearch(type: .arrivalSearch)
            return false
        default:
            return true
        }
    }
}
