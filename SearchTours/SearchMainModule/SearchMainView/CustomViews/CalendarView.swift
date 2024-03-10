//
//  CalendarView.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

import UIKit

protocol CalendarViewViewDelegate {
    func changedDepartureDate(date: Date?)
    func clickedDoneButton()
}

final class CalendarView: UIView {
    var delegateView: CalendarViewViewDelegate?
    
    private let startDepartureDate: Date
    
    // MARK: UI components
    
    private lazy var calendar         = createCalendar()
    private lazy var doneButton       = DoneButton()
    
    // MARK: Initialization
    
    init(startDepartureDate: Date, frame: CGRect) {
        self.startDepartureDate = startDepartureDate
        
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
        addSubview(calendar)
        addSubview(doneButton)
        
        doneButton.addTarget(self,
                             action: #selector(doneButtonAction),
                             for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendar.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            calendar.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -16),
            calendar.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            calendar.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            doneButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: calendar.bottomAnchor, constant: 32),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    // MARK: Creating UI components
    
    private func createCalendar() -> UIDatePicker {
        let calendar = UIDatePicker()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.datePickerMode = .date
        calendar.preferredDatePickerStyle = .inline
        calendar.date = startDepartureDate
        calendar.addTarget(self, action: #selector(changedDate), for: .valueChanged)
        
        let localeID = Locale.preferredLanguages.first
        calendar.locale = Locale(identifier: localeID ?? "")
        return calendar
    }
    
    // Button actions
    
    @objc private func changedDate(sender: UIDatePicker) {
        delegateView?.changedDepartureDate(date: sender.date)
    }
    
    @objc private func doneButtonAction() {
        delegateView?.clickedDoneButton()
    }
}
