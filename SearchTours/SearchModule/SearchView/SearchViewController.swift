//
//  SearchViewController.swift
//  SearchTours
//
//  Created by Наталья on 04.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    var output: SearchViewOutput?
    
    private var departCities: [DepartCityModel] = []
    private var countries: [CountryModel] = []
    private var searchResults: [String] = []
    private var typeModule: SearchModuleType = .departureSearch
    
    // MARK: UI components
    
    private lazy var tableView = createTableView()
    private lazy var searchBar = SearchBar(typeModule: self.typeModule)
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        typeModule = output?.getTypeModule() ?? .departureSearch
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.loadData()
        setupConstraints()
    }
    
    // MARK: Private functions
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: searchBar.frame.height + 24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // MARK: Creating UI components
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, 
                           forCellReuseIdentifier: "searchCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    func loadedCities(_ cities: [DepartCityModel]) {
        self.departCities = cities
        searchResults = cities.map { $0.name }
        tableView.reloadData()
    }
    
    func loadedCountries(_ countries: [CountryModel]) {
        self.countries = countries
        searchResults = countries.map { $0.name }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell",
                                                       for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.updateData(title: searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch typeModule {
        case .departureSearch:
            guard let index = departCities.firstIndex(where: { $0.name == searchResults[indexPath.row] }) else { return }
            output?.selectedDepartCity(id: departCities[index].id,
                                       name: departCities[index].name)
        case .arrivalSearch:
            guard let index = countries.firstIndex(where: { $0.name == searchResults[indexPath.row] }) else { return }
            output?.selectedArrivalCountry(id: countries[index].id,
                                           name: countries[index].name)
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch typeModule {
        case .departureSearch:
            let departCitiesNames = departCities.map { $0.name }
            searchResults = searchText.isEmpty ? departCitiesNames : departCitiesNames.filter {
                return $0.range(of: searchText, options: .caseInsensitive) != nil
            }
        case .arrivalSearch:
            let countriesNames = countries.map { $0.name }
            searchResults = searchText.isEmpty ? countriesNames : countriesNames.filter {
                return $0.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
