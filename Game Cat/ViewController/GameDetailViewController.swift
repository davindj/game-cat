//
//  GameDetailViewController.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/09/22.
//

import UIKit

class GameDetailViewController: UIViewController {
    private var game: Game!
    private let scrollView: UIScrollView = UIScrollView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    private let gameDetailHeaderView: GameDetailHeaderView = GameDetailHeaderView()
    private let gameInformationView: GameInformationView = GameInformationView()
    private let gameDetailDescriptionView: GameDetailDescriptionView = GameDetailDescriptionView()
    private let gameDetailTagView: GameDetailTagView = GameDetailTagView()
    private let gameDetailRatingView: GameDetailRatingView = GameDetailRatingView()
    private let gameDetailStoreView: GameDetailStoreView = GameDetailStoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViewHierarchy()
        configConstraints()
        displayGameData()
    }
    
    private func configViewController() {
        view.backgroundColor = .white
        title = game.name
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    private func configViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(gameDetailHeaderView)
        stackView.addArrangedSubview(gameInformationView)
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
        loadGameDetail()
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
                // TODO: handle erro load game detail dan kasih alert
                print("Load game detail failed")
                return
            }
            guard let gameDetail = gameDetail else { return }
            DispatchQueue.main.async {
                self.displayGameDetail(gameDetail: gameDetail)
            }
        }
    }
    private func displayGameDetail(gameDetail: GameDetail) {
        // Information
        gameInformationView.configValue(developers: gameDetail.developers,
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
    }
}

extension GameDetailViewController {
    private static func initImgViewStar() -> UIImageView {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "star.fill")
        imgView.tintColor = UIColor(rgb: 0x999999)
        return imgView
    }
}
