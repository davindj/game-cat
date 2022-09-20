//
//  HomeViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 18/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    private static let CELLNAME: String = "gameCell"
    private var games: [String] = []
    
    private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "game name... ex: terraria, dota, touhou"
        return searchController
    }()
    private var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configTableView()
        configNavigation()
        configConstraints()
        loadGames()
    }
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: HomeViewController.CELLNAME)
        self.view.addSubview(tableView)
    }
    private func configNavigation() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        title = "Games"
    }
    private func configConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = UIScreen.main.bounds
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    private func loadGames() {
        games = ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        games += ["game 1", "game 2", "game 3"]
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.CELLNAME, for: indexPath) as? GameTableViewCell {
            cell.initValue()
            return cell
        }
       return UITableViewCell()
    }
}
