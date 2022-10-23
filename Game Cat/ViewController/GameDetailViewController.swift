//
//  GameDetailViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/09/22.
//

import UIKit
import RxSwift
import RxCocoa

enum AddToFavoriteError: Error {
    case containerNotLoaded
    case gameDetailNotLoaded
    case failedToSaveContext
}

enum RemoveFromFavoriteError: Error {
    case containerNotLoaded
    case gameNotFavorite
    case failedToSaveContext
}

class GameDetailViewController: UIViewController {
    // PARAM
    private var game: Game!
    private var isFavorite: Bool = false
    
    // Var
    private var gameDetail: GameDetail?
    private let disposeBag: DisposeBag = DisposeBag()
    
    // Components
    private let favoriteBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
    private let scrollView: UIScrollView = UIScrollView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    private let gameDetailHeaderView: GameDetailHeaderView = GameDetailHeaderView()
    private let gameDetailInformationView: GameDetailInformationView = GameDetailInformationView()
    private let gameDetailDescriptionView: GameDetailDescriptionView = GameDetailDescriptionView()
    private let gameDetailTagView: GameDetailTagView = GameDetailTagView()
    private let gameDetailRatingView: GameDetailRatingView = GameDetailRatingView()
    private let gameDetailStoreView: GameDetailStoreView = GameDetailStoreView()
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configNavBar()
        configViewHierarchy()
        configConstraints()
        displayGameData()
    }
    
    private func configViewController() {
        view.backgroundColor = .white
        title = game.name
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    private func configNavBar() {
        self.refreshFavoriteBarBtn()
        favoriteBarButtonItem.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if !self.isFavorite {
                    self.tryAddToFavorite()
                } else {
                    self.tryRemoveFromFavorite()
                }
            })
            .disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
    }
    
    private func refreshFavoriteBarBtn() {
        favoriteBarButtonItem.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
    
    private func toggleFavoriteOn() {
        isFavorite = true
        self.refreshFavoriteBarBtn()
    }
    
    private func toggleFavoriteOff() {
        isFavorite = false
        self.refreshFavoriteBarBtn()
    }
    
    private func tryAddToFavorite() {
        do {
            try self.addToFavorite()
            DispatchQueue.main.async {
                self.toggleFavoriteOn()
            }
        } catch {
            DispatchQueue.main.async {
                switch error {
                case AddToFavoriteError.containerNotLoaded:
                    self.showAlert(title: "Core Data Not Loaded", message: "please try to reload the app")
                case AddToFavoriteError.gameDetailNotLoaded:
                    self.showAlert(title: "Game Detail Not Loaded", message: "please try again after game detail loaded")
                case AddToFavoriteError.failedToSaveContext:
                    self.showAlert(title: "Couldn't Add Game to Favorites", message: "please try to reload the app")
                default:
                    self.showAlert(title: "Unknown Error", message: "please try to reload the app")
                }
            }
        }
    }
    
    private func addToFavorite() throws {
        guard let container = self.container else {
            throw AddToFavoriteError.containerNotLoaded
        }
        guard let gameDetail = self.gameDetail else {
            throw AddToFavoriteError.gameDetailNotLoaded
        }
        do {
            try container.saveGame(game: game, detail: gameDetail)
        } catch PersistentContainerSaveContextError.failedToSaveContext {
            throw AddToFavoriteError.failedToSaveContext
        }
    }
    
    private func tryRemoveFromFavorite() {
        do {
            try self.removeFromFavorite()
            DispatchQueue.main.async {
                self.toggleFavoriteOff()
            }
        } catch {
            DispatchQueue.main.async {
                switch error {
                case RemoveFromFavoriteError.containerNotLoaded:
                    self.showAlert(title: "Core Data Not Loaded", message: "please try to reload the app")
                case RemoveFromFavoriteError.gameNotFavorite:
                    self.showAlert(title: "Game Not in Favorites", message: "please try to re-open detail page")
                case RemoveFromFavoriteError.failedToSaveContext:
                    self.showAlert(title: "Game Not in Favorites", message: "please try to re-open detail page")
                default:
                    self.showAlert(title: "Unknown Error", message: "please reload the app")
                }
            }
        }
    }
    
    private func removeFromFavorite() throws {
        guard let container = self.container else {
            throw RemoveFromFavoriteError.containerNotLoaded
        }
        do {
            let gameId = Int64(game.id)
            try container.deleteGame(gameId: gameId)
        } catch PersistentContainerDeleteGameError.gameNotFound {
            throw RemoveFromFavoriteError.gameNotFavorite
        } catch PersistentContainerSaveContextError.failedToSaveContext {
            throw RemoveFromFavoriteError.failedToSaveContext
        }
    }
    
    private func configViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(gameDetailHeaderView)
        stackView.addArrangedSubview(gameDetailInformationView)
        stackView.addArrangedSubview(gameDetailDescriptionView)
        stackView.addArrangedSubview(gameDetailTagView)
        stackView.addArrangedSubview(gameDetailRatingView)
        stackView.addArrangedSubview(gameDetailStoreView)
    }
    
    private func configConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func displayGameData() {
        loadGameHeader { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let genres = self.game.genres
                self.displayGameHeader(genres: genres, image: image)
            }
        }
        if gameDetail == nil {
            loadGameDetail()
        } else {
            displayGameDetail()
        }
    }
    
    private func loadGameHeader(callback: @escaping (UIImage?) -> Void) {
        guard let bgImage = game.backgroundImage else { return }
        Service.loadImage(imageUrl: bgImage) { image in
            guard let image = image else {
                callback(nil)
                return
            }
            callback(image)
        }
    }
    
    private func displayGameHeader(genres: [String], image: UIImage?) {
        let displayImage = image ?? UIImage(systemName: "xmark.seal")!
        gameDetailHeaderView.configValue(genres: genres, image: displayImage)
    }
    
    private func loadGameDetail() {
        Service.getGameDetail(gameId: game.id) { [weak self] gameDetail, error in
            guard let self = self else { return }
            if error != nil {
                DispatchQueue.main.async {
                    self.showAlert(title: "Game Detail cannot be loaded", message: "please try to reload by re-open this page")
                }
                return
            }
            self.gameDetail = gameDetail
            DispatchQueue.main.async {
                self.displayGameDetail()
            }
        }
    }
    private func displayGameDetail() {
        guard let gameDetail = self.gameDetail else { return }
        // Information
        gameDetailInformationView.configValue(developers: gameDetail.developers,
                                              publishers: gameDetail.publishers,
                                              releasedAt: game.released,
                                              updatedAt: gameDetail.updatedDate)
        
        // Description
        let descriptions = gameDetail.description.components(separatedBy: "\n")
        gameDetailDescriptionView.configValue(descriptions: descriptions)
        
        // Tags
        gameDetailTagView.configValue(tags: gameDetail.tags)
        
        // Rating
        let starPercentage = RatingPercentage(
            starPercentage5: Float(gameDetail.ratingsStar5.percent) / 100.0,
            starPercentage4: Float(gameDetail.ratingsStar4.percent) / 100.0,
            starPercentage3: Float(gameDetail.ratingsStar3.percent) / 100.0,
            starPercentage2: Float(gameDetail.ratingsStar2.percent) / 100.0,
            starPercentage1: Float(gameDetail.ratingsStar1.percent) / 100.0)
        gameDetailRatingView.configValue(ratingAvg: game.rating, ratingCount: gameDetail.totalRating, ratingPerc: starPercentage)
        
        // Store
        gameDetailStoreView.configValue(stores: gameDetail.stores)
    }
    
    // MARK: Public Function
    func configGame(game: Game) {
        self.game = game
        toggleFavoriteOff()
    }
    
    func configFavoriteGame(game: Game, gameDetail: GameDetail) {
        self.game = game
        self.gameDetail = gameDetail
        toggleFavoriteOn()
    }
}
