//
//  ToursViewController.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

final class ToursViewController: UIViewController {
    var output: ToursViewOutput?
    
    private var tours: [OfferModel] = []
    private var currentPage = 1
    private var totalCountItems = 1
    private let limitItems = 10
    private let testImageUrl = "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg"
    
    // MARK: UI components
    
    private lazy var tableView = createTableView()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.loadData(limit: limitItems, offset: 0)
        setupConstraints()
    }
    
    // MARK: Private functions
    
    private func setupNavigationBar() {
        setNavigationBackButton()
        
        guard let date = output?.getDepartureDate(),
              let nights = output?.getNightsCount(),
              let persons = output?.getPersonsCount()
        else { return }
        createNavigationBarWithTwoLabel(title: output?.getArrivalCountryName(),
                                        description: .tours(.navBarDescriptionText(date: date, nights: nights, persons: persons)))
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // MARK: Creating UI components
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ToursTableViewCell.self, 
                           forCellReuseIdentifier: "tourCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 6
        tableView.backgroundColor = .secondarySystemBackground
        return tableView
    }
}

// MARK: - ToursViewInput

extension ToursViewController: ToursViewInput {
    func loadedSearchResults(_ searchResults: SearchResultModel) {
        tours = searchResults.results
        totalCountItems = searchResults.stats.hotelsCount
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ToursViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tours.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tourCell",
                                                       for: indexPath) as? ToursTableViewCell else { return UITableViewCell() }
        cell.updateData(tour: tours[indexPath.section].offer)
        cell.updateDates(departureDate: output?.getDepartureDate(),
                         nightsCount: output?.getNightsCount())
        cell.loadHotelImage(url: testImageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tours.count - 1, currentPage * limitItems < totalCountItems {
            output?.loadData(limit: limitItems, 
                             offset: currentPage * limitItems)
            currentPage += 1
        }
    }
}

// MARK: - UITableViewDelegate

extension ToursViewController: UITableViewDelegate {
    
}
