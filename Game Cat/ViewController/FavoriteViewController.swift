//
//  FavoriteViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/10/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    private static let CELLNAME: String = "gameCell"
    private var games: [CDGame] = []
    
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
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: FavoriteViewController.CELLNAME)
        self.view.addSubview(tableView)
    }
    
    private func configNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorite"
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
        guard let container = self.container else { return }
        do {
            let cdgames = try container.getGames()
            self.games = cdgames
        } catch {
            self.showAlert(title: "Core Data cannot be loaded", message: "favorite feature may not working properly")
        }
        if self.games.isEmpty {
            showNoDataLabel()
        } else {
            hideNoDataLabel()
        }
        self.tableView.reloadData()
    }
    
    private func showNoDataLabel() {
        let labelNoData = UILabel(frame: CGRect(x: 0,
                                                y: 0,
                                                width: tableView.bounds.size.width,
                                                height: tableView.bounds.size.height))
        labelNoData.text = "No favorite game\n\nyou can add favorite by\ngo to game detail and press 💜"
        labelNoData.textColor = .black
        labelNoData.textAlignment = .center
        labelNoData.numberOfLines = 0
        tableView.separatorStyle = .none
        tableView.backgroundView = labelNoData
    }
    
    private func hideNoDataLabel() {
        tableView.separatorStyle = .singleLine
        tableView.backgroundView = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadGames()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return games.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteViewController.CELLNAME, for: indexPath) as? GameTableViewCell {
            let cdGame = games[indexPath.row]
            cell.initValueFavorite(cdgame: cdGame)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cdGame = games[indexPath.row]
        let detailVC = GameDetailViewController()
        detailVC.configFavoriteGame(game: cdGame.toGame(), gameDetail: cdGame.toGameDetail())
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
