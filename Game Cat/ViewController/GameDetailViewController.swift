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
    private let contentView: UIView = UIView()
    private let imgViewGame: UIImageView = UIImageView()
    private let labelGameGenres: UILabel = UILabel.initLabelSecondary()
    private let labelDevelopers: UILabel = UILabel.initLabelSecondary(text: "Developer")
    private let labelDevelopersValue: UILabel = UILabel.initLabelPrimary()
    private let labelPublishers: UILabel = UILabel.initLabelSecondary(text: "Publisher")
    private let labelPublishersValue: UILabel = UILabel.initLabelPrimary()
    private let labelReleased: UILabel = UILabel.initLabelSecondary(text: "Released")
    private let labelReleasedValue: UILabel = UILabel.initLabelPrimary()
    private let labelLastUpdate: UILabel = UILabel.initLabelSecondary(text: "Last Update")
    private let labelLastUpdateValue: UILabel = UILabel.initLabelPrimary()
    private let labelGameDescription: UILabel = UILabel.initLabelPrimary()
    private let labelSubHeaderTags: UILabel = UILabel.initLabelSubHeader(text: "Tags")
    private let labelTags: UILabel = UILabel.initLabelPrimary()
    private let ratingView: RatingView = RatingView()
    private let labelSubHeaderAvailableOn: UILabel = UILabel.initLabelSubHeader(text: "Available On")
    private let labelStores: UILabel = UILabel.initLabelPrimary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        displayGameData()
        configViewHierarchy()
        configConstraints()
    }
    private func configViewController() {
        view.backgroundColor = .white
        title = game.name
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    private func displayGameData() {
        displayGameCommonAttribute()
        loadGameImage()
        loadGameDetail()
    }
    private func displayGameCommonAttribute() {
        labelGameGenres.text = game.genres.joined(separator: " . ")
        labelReleasedValue.text = game.released ?? "-"
    }
    private func loadGameImage() {
        imgViewGame.image = nil
        guard let bgImage = game.backgroundImage else { return }
        Service.loadImage(imageUrl: bgImage) { [weak self] image in
            guard let self = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imgViewGame.image = image
            }
        }
    }
    private func loadGameDetail() {
        Service.getGameDetail(gameId: game.id) { [weak self] gameDetail, error in
            guard let self = self else { return }
            if error != nil {
                // TODO: handle erro load game detail
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
        labelDevelopersValue.text = gameDetail.developers.joined(separator: "\n")
        labelPublishersValue.text = gameDetail.publishers.joined(separator: "\n")
        labelGameDescription.text = gameDetail.description.components(separatedBy: "\n").joined(separator: "\n\n")
        labelTags.text = gameDetail.tags.joined(separator: " . ")
        labelStores.text = gameDetail.stores.joined(separator: "\n")
        labelLastUpdateValue.text = gameDetail.updatedDate ?? "-"
        let starPercentage = RatingPercentage(
            starPercentage5: Float(gameDetail.ratingsStar5.percent) / 100.0,
            starPercentage4: Float(gameDetail.ratingsStar4.percent) / 100.0,
            starPercentage3: Float(gameDetail.ratingsStar3.percent) / 100.0,
            starPercentage2: Float(gameDetail.ratingsStar2.percent) / 100.0,
            starPercentage1: Float(gameDetail.ratingsStar1.percent) / 100.0)
        ratingView.configValue(ratingAvg: game.rating, ratingCount: gameDetail.totalRating, ratingPerc: starPercentage)
        print("Displaying game detail")
    }
    private func configViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imgViewGame)
        contentView.addSubview(labelGameGenres)
        contentView.addSubview(labelDevelopers)
        contentView.addSubview(labelDevelopersValue)
        contentView.addSubview(labelPublishers)
        contentView.addSubview(labelPublishersValue)
        contentView.addSubview(labelReleased)
        contentView.addSubview(labelReleasedValue)
        contentView.addSubview(labelLastUpdate)
        contentView.addSubview(labelLastUpdateValue)
        contentView.addSubview(labelGameDescription)
        contentView.addSubview(labelSubHeaderTags)
        contentView.addSubview(labelTags)
        contentView.addSubview(ratingView)
        contentView.addSubview(labelSubHeaderAvailableOn)
        contentView.addSubview(labelStores)
    }
    
    private func configConstraints() {
        configConstraintsScrollView()
        configConstraintsHeader()
        configConstraintsMainInformation()
        configConstraintsTags()
        configConstraintsAvailableOn()
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: labelTags.bottomAnchor, constant: 20),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    private func configConstraintsScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    private func configConstraintsHeader() {
        imgViewGame.translatesAutoresizingMaskIntoConstraints = false
        labelGameGenres.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgViewGame.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgViewGame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgViewGame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgViewGame.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3.0/4.0),
            
            labelGameGenres.topAnchor.constraint(equalTo: imgViewGame.bottomAnchor, constant: 20),
            labelGameGenres.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    private func configConstraintsMainInformation() {
        labelDevelopers.translatesAutoresizingMaskIntoConstraints = false
        labelDevelopersValue.translatesAutoresizingMaskIntoConstraints = false
        labelPublishers.translatesAutoresizingMaskIntoConstraints = false
        labelPublishersValue.translatesAutoresizingMaskIntoConstraints = false
        labelReleased.translatesAutoresizingMaskIntoConstraints = false
        labelReleasedValue.translatesAutoresizingMaskIntoConstraints = false
        labelLastUpdate.translatesAutoresizingMaskIntoConstraints = false
        labelLastUpdateValue.translatesAutoresizingMaskIntoConstraints = false
        labelGameDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelDevelopers.widthAnchor.constraint(equalTo: labelLastUpdate.widthAnchor, multiplier: 1),
            labelPublishers.widthAnchor.constraint(equalTo: labelLastUpdate.widthAnchor, multiplier: 1),
            labelReleased.widthAnchor.constraint(equalTo: labelLastUpdate.widthAnchor, multiplier: 1),
            
            labelDevelopers.topAnchor.constraint(equalTo: labelGameGenres.bottomAnchor, constant: 10),
            labelDevelopers.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelDevelopersValue.topAnchor.constraint(equalTo: labelDevelopers.topAnchor),
            labelDevelopersValue.leadingAnchor.constraint(equalTo: labelDevelopers.trailingAnchor, constant: 20),
            
            labelPublishers.topAnchor.constraint(equalTo: labelDevelopersValue.bottomAnchor),
            labelPublishers.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelPublishersValue.topAnchor.constraint(equalTo: labelPublishers.topAnchor),
            labelPublishersValue.leadingAnchor.constraint(equalTo: labelPublishers.trailingAnchor, constant: 20),
            
            labelReleased.topAnchor.constraint(equalTo: labelPublishersValue.bottomAnchor),
            labelReleased.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelReleasedValue.topAnchor.constraint(equalTo: labelReleased.topAnchor),
            labelReleasedValue.leadingAnchor.constraint(equalTo: labelReleased.trailingAnchor, constant: 20),
            
            labelLastUpdate.topAnchor.constraint(equalTo: labelReleasedValue.bottomAnchor),
            labelLastUpdate.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelLastUpdateValue.topAnchor.constraint(equalTo: labelLastUpdate.topAnchor),
            labelLastUpdateValue.leadingAnchor.constraint(equalTo: labelLastUpdate.trailingAnchor, constant: 20),
            
            labelGameDescription.topAnchor.constraint(equalTo: labelLastUpdateValue.bottomAnchor, constant: 10),
            labelGameDescription.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelGameDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    private func configConstraintsTags() {
        labelSubHeaderTags.translatesAutoresizingMaskIntoConstraints = false
        labelTags.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelSubHeaderTags.topAnchor.constraint(equalTo: labelGameDescription.bottomAnchor, constant: 20),
            labelSubHeaderTags.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelTags.topAnchor.constraint(equalTo: labelSubHeaderTags.bottomAnchor),
            labelTags.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelTags.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    private func configConstraintsAvailableOn() {
        labelSubHeaderAvailableOn.translatesAutoresizingMaskIntoConstraints = false
        labelStores.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelSubHeaderAvailableOn.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20),
            labelSubHeaderAvailableOn.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelStores.topAnchor.constraint(equalTo: labelSubHeaderAvailableOn.bottomAnchor),
            labelStores.leadingAnchor.constraint(equalTo: labelGameGenres.leadingAnchor),
            labelStores.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            contentView.bottomAnchor.constraint(equalTo: labelStores.bottomAnchor, constant: 20)
        ])
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
