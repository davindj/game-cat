//
//  HomeViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 18/09/22.
//

import UIKit
import RxSwift
import RxCocoa

struct GameTableItem {
    let game: Game
    let coredata: CDGame?
}

class HomeViewController: UIViewController {
    // Const
    private static let CELLNAME: String = "gameCell"
    // Var
    private var gameTableItems: [GameTableItem] = []
    private var disposeBag: DisposeBag = DisposeBag()
    // Components
    private let aboutDeveloperBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                                                               style: .plain,
                                                                               target: nil, action: nil)
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
        navigationItem.title = "Games"
        navigationItem.rightBarButtonItem = aboutDeveloperBarButtonItem
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
        
        aboutDeveloperBarButtonItem.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.navigateToAboutDeveloperPage()
            })
            .disposed(by: disposeBag)
    }
    
    private func loadGames(searchText: String) {
        Service.getGames(searchText: searchText) { [weak self] games, errorStatus in
            guard let self = self else { return }
            if errorStatus != nil {
                DispatchQueue.main.async {
                    self.showAlert(title: "Cannot load games", message: "please try again later")
                }
                return
            }
            self.gameTableItems = games.map { GameTableItem(game: $0, coredata: nil) }
            DispatchQueue.main.async {
                self.mapAndReloadGameTableItemsWithFavorite()
            }
        }
    }
    
    private func mapAndReloadGameTableItemsWithFavorite() {
        var cdgames: [CDGame] = []
        do {
            cdgames = try self.container?.getGames() ?? []
        } catch {
            self.showAlert(title: "Core Data cannot be loaded", message: "favorite feature may not working properly")
        }
        self.gameTableItems = self.gameTableItems.map { gameTableItem in
            let game = gameTableItem.game
            let cdgame = cdgames.first { $0.id == game.id }
            return GameTableItem(game: game, coredata: cdgame)
        }
        if self.gameTableItems.isEmpty {
            showNoDataLabel()
        } else {
            hideNoDataLabel()
        }
        self.tableView.reloadData()
        self.tableView.reloadData()
    }
    
    private func showNoDataLabel() {
        let labelNoData = UILabel(frame: CGRect(x: 0,
                                                y: 0,
                                                width: tableView.bounds.size.width,
                                                height: tableView.bounds.size.height))
        labelNoData.text = "No game found"
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
    
    private func navigateToAboutDeveloperPage() {
        let aboutDevVc = AboutDeveloperViewController()
        navigationController?.pushViewController(aboutDevVc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapAndReloadGameTableItemsWithFavorite()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameTableItems.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameTableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.CELLNAME, for: indexPath) as? GameTableViewCell {
            let gameTabItem = gameTableItems[indexPath.row]
            if let cdgame = gameTabItem.coredata { // is favorite
                cell.initValueFavorite(cdgame: cdgame)
            } else {
                cell.initValue(game: gameTabItem.game)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameTableItem = gameTableItems[indexPath.row]
        let detailVC = GameDetailViewController()
        if let cdGame = gameTableItem.coredata {
            detailVC.configFavoriteGame(game: cdGame.toGame(), gameDetail: cdGame.toGameDetail())
        } else {
            detailVC.configGame(game: gameTableItem.game)
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
