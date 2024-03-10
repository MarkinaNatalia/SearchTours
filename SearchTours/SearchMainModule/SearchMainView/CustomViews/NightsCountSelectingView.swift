//
//  NightsCountSelectingView.swift
//  SearchTours
//
//  Created by Наталья on 08.03.2024.
//

import UIKit

protocol NightsCountSelectingViewDelegate {
    func changedNightsCount(nightsCount: Int)
    func clickedDoneButton()
}

final class NightsCountSelectingView: UIView {
    var delegateView: NightsCountSelectingViewDelegate?
    
    private let startNightsCount: Int
    private var maxNightsCount = 21
    
    // MARK: UI components
    
    private lazy var titleLabel         = createTitleLabel()
    private lazy var pickerView         = createPickerView()
    private lazy var doneButton         = DoneButton()
    
    // MARK: Initialization
    
    init(startNightsCount: Int, frame: CGRect) {
        self.startNightsCount = startNightsCount
        
        super.init(frame: frame)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup settings
    
    private func setupSettings() {
        backgroundColor = .customColor(.lightGrayColor)
        addSubviews()
        setupConstraints()
    }
    
    // MARK: Private functions
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(pickerView)
        addSubview(doneButton)
        
        doneButton.addTarget(self,
                             action: #selector(doneButtonAction),
                             for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            pickerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            doneButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: pickerView.bottomAnchor, constant: 32),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    // MARK: Creating UI components
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = .searchMain(.nightCountTitle)
        label.textColor = .customColor(.blackColor)
        label.font = .customFont(.semiBold, size: 20)
        return label
    }
    
    private func createPickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(startNightsCount - 1, inComponent: 0, animated: true)
        return picker
    }
    
    // Button actions
    
    @objc private func doneButtonAction() {
        delegateView?.clickedDoneButton()
    }
}

// MARK: - UIPickerViewDataSource {

extension NightsCountSelectingView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxNightsCount + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
}

// MARK: - UIPickerViewDelegate {

extension NightsCountSelectingView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegateView?.changedNightsCount(nightsCount: row + 1)
    }
}
