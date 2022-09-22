//
//  HomeViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 18/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private static let CELLNAME: String = "gameCell"
    private var games: [Game] = []
    private var disposeBag: DisposeBag = DisposeBag()
    
    private var searchController: UISearchController = UISearchController(searchResultsController: nil)
    private var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configTableView()
        configSearchController()
        configNavigation()
        configConstraints()
        configRx()
    }
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: HomeViewController.CELLNAME)
        self.view.addSubview(tableView)
    }
    private func configSearchController() {
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "game name... ex: terraria, dota, touhou"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
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
    private func configRx() {
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] searchText in
                guard let self = self else { return }
                self.loadGames(searchText: searchText)
            })
            .disposed(by: disposeBag)
    }
    private func loadGames(searchText: String) {
        Service.getGames(searchText: searchText) { [weak self] games, errorStatus in
            guard let self = self else { return }
            if errorStatus != nil {
                // TODO: kasih alert
                print("ada error boi")
                return
            }
            self.games = games
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.CELLNAME, for: indexPath) as? GameTableViewCell {
            let game = games[indexPath.row]
            cell.initValue(game: game)
            return cell
        }
       return UITableViewCell()
    }
}
