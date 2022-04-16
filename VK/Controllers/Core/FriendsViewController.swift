//
//  FriendsViewController.swift
//  VK
//
//  Created by Арген on 01.04.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Поиск"
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private var friendsArray: [FriendsArray] = []
    var filteredArray = [FriendsArray]()
    
    private var seacrhBarTextIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !seacrhBarTextIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setConstraints()
        loadFriends()
    }
    
    private func initialSetup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Friends"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func loadFriends() {
        APICaller.shared.getFriends { [weak self] results in
            switch results {
            case .success(let friends):
                self?.friendsArray = friends
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterArray(text)
    }
    
    private func filterArray(_ searchText: String) {
        filteredArray = friendsArray.filter({ (filter: FriendsArray) -> Bool in
            return (filter.firstName?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredArray.count : friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        let model = isFiltering  ? filteredArray[indexPath.row] : friendsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension FriendsViewController {
    private func setConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
