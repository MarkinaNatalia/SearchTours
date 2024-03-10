//
//  SearchMainViewController.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

final class SearchMainViewController: UIViewController {
    var output: SearchMainViewOutput?
    
    private var departureDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())
    
    private var adultsCount = 1
    private var kidsCount = 0
    private var kidsAges: [Int] = []
    
    private var nightsCount = 10
    
    // MARK: UI components
    
    private lazy var countryDepartureTextField   = InputField(type: .countryDeparture, delegateView: self)
    private lazy var countryArrivalTextField     = InputField(type: .countryArrival, delegateView: self)
    private lazy var departureDateTextField      = InputField(type: .departureDate, customInputView: calendarView, delegateView: self)
    private lazy var nightCountTextField         = InputField(type: .nightCount, customInputView: nightsCountSelectingView, delegateView: self)
    private lazy var personCountTextField        = InputField(type: .personCount, customInputView: addingPersonView, delegateView: self)
    private lazy var searchTourButton            = SearchTourButton(title: .searchMain(.searchTourButtonTitle))
    private lazy var calendarView                = createCalendarView()
    private lazy var addingPersonView            = createAddingPersonView()
    private lazy var nightsCountSelectingView    = createNightCountSelectingView()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Private functions
    
    private func setupNavigationBar() {
        navigationItem.title = .searchMain(.searchMainNavTitle)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews() {
        view.addSubview(countryDepartureTextField)
        view.addSubview(countryArrivalTextField)
        view.addSubview(departureDateTextField)
        view.addSubview(nightCountTextField)
        view.addSubview(personCountTextField)
        view.addSubview(searchTourButton)
        
        searchTourButton.addTarget(self,
                                   action: #selector(searchTourButtonAction),
                                   for: .touchUpInside)
        
        setDepartureDateText()
        setNightsCountText(nightsCount: nightsCount)
        setPersonsCountText(adultsCount: adultsCount, 
                            kidsCount: kidsCount)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countryDepartureTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            countryDepartureTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            countryDepartureTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + 36),
            
            countryArrivalTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            countryArrivalTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            countryArrivalTextField.topAnchor.constraint(equalTo: countryDepartureTextField.bottomAnchor, constant: 1),
            
            departureDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            departureDateTextField.topAnchor.constraint(equalTo: countryArrivalTextField.bottomAnchor, constant: 8),
            
            nightCountTextField.leftAnchor.constraint(equalTo: departureDateTextField.rightAnchor, constant: 1),
            nightCountTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nightCountTextField.topAnchor.constraint(equalTo: countryArrivalTextField.bottomAnchor, constant: 8),
            nightCountTextField.widthAnchor.constraint(equalTo: departureDateTextField.widthAnchor, multiplier: 1),
            
            personCountTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            personCountTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            personCountTextField.topAnchor.constraint(equalTo: departureDateTextField.bottomAnchor, constant: 1),
            
            searchTourButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            searchTourButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            searchTourButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.safeAreaInsets.bottom + 16))
        ])
    }
    
    private func setDepartureDateText() {
        guard let date = departureDate else { 
            departureDateTextField.updateText("")
            return
        }
        departureDateTextField.updateText(.searchMain(.departureDateText(date: date)))
    }
    
    private func setPersonsCountText(adultsCount: Int, kidsCount: Int) {
        let adultsCountString: String = adultsCount == 0 ? "" : .searchMain(.adultsCount(count: adultsCount))
        let kidsCountString: String = kidsCount == 0 ? "" : .searchMain(.kidsCount(count: kidsCount))

        personCountTextField.updateText(adultsCountString + kidsCountString)
    }
    
    private func setNightsCountText(nightsCount: Int) {
        nightCountTextField.updateText(.searchMain(.nightsCountText(count: nightsCount)))
    }
    
    // MARK: Creating UI components
    
    private func createCalendarView() -> CalendarView {
        let view = CalendarView(startDepartureDate: departureDate ?? Date(),
                                frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 400))
        view.delegateView = self
        return view
    }
    
    private func createAddingPersonView() -> AddingPersonView {
        let view = AddingPersonView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 400))
        view.delegateView = self
        return view
    }
    
    private func createNightCountSelectingView() -> NightsCountSelectingView {
        let view = NightsCountSelectingView(startNightsCount: nightsCount,
                                            frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 300))
        view.delegateView = self
        return view
    }
    
    // MARK: Buttons action
    
    @objc private func searchTourButtonAction() {
        guard let departureDate = departureDate else { return }
        
        output?.searchTourButtonAction(departureDate: departureDate,
                                       nightsCount: nightsCount,
                                       adultsCount: adultsCount,
                                       kidsCount: kidsCount,
                                       kidsAges: kidsAges)
    }
}

// MARK: - SearchMainViewInput

extension SearchMainViewController: SearchMainViewInput {
    func updateCountryDepartureText(name: String) {
        countryDepartureTextField.updateText(name)
    }
    
    func updateCountryArrivalText(name: String) {
        countryArrivalTextField.updateText(name)
    }
}

// MARK: - CalendarViewViewDelegate

extension SearchMainViewController: CalendarViewViewDelegate {
    func changedDepartureDate(date: Date?) {
        self.departureDate = date
        setDepartureDateText()
    }
    
    func clickedDoneButton() {
        view.endEditing(true)
    }
}

// MARK: - AddingPersonViewDelegate

extension SearchMainViewController: AddingPersonViewDelegate {
    func changedPersonCount(adultsCount: Int, kidsCount: Int, kidsAges: [Int]) {
        setPersonsCountText(adultsCount: adultsCount, kidsCount: kidsCount)
        self.adultsCount = adultsCount
        self.kidsCount = kidsCount
        self.kidsAges = kidsAges
    }
}

// MARK: - NightsCountSelectingViewDelegate

extension SearchMainViewController: NightsCountSelectingViewDelegate {
    func changedNightsCount(nightsCount: Int) {
        self.nightsCount = nightsCount
        setNightsCountText(nightsCount: nightsCount)
    }
}

// MARK: - InputFieldDelegate

extension SearchMainViewController: InputFieldDelegate {
    func openSearch(type: SearchModuleType) {
        output?.openSearch(type: type)
    }
}
