//
//  GameTableViewCell.swift
//  Game Cat
//
//  Created by Davin Djayadi on 18/09/22.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    // MARK: Components
    private let imgViewGameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    private let stackViewGameAttribute: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    private let stackViewRating: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x000000)
        return label
    }()
    private let labelGenre: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgb: 0x999999)
        return label
    }()
    private let labelRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgb: 0x999999)
        return label
    }()
    private let imgViewRating: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(rgb: 0x999999)
        return imageView
    }()
    private let labelReleaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgb: 0x999999)
        return label
    }()
    private let imgViewFavorite: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = UIColor(rgb: 0x999999)
        return imageView
    }()
    private let spacer: UIView = UIView()
    private let spacerRating: UIView = UIView()
    
    // MARK: Overrides
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configViewHierarchy()
        configAutoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViewHierarchy() {
        addSubview(imgViewGameIcon)
        addSubview(stackViewGameAttribute)
        addSubview(imgViewFavorite)
        
        stackViewGameAttribute.addArrangedSubview(labelName)
        stackViewGameAttribute.addArrangedSubview(labelGenre)
        stackViewGameAttribute.addArrangedSubview(spacer)
        stackViewGameAttribute.addArrangedSubview(stackViewRating)
        
        stackViewRating.addArrangedSubview(labelRating)
        stackViewRating.addArrangedSubview(imgViewRating)
        stackViewRating.addArrangedSubview(spacerRating)
        stackViewRating.addArrangedSubview(labelReleaseDate)
        stackViewRating.addArrangedSubview(UIView())
    }
    
    private func configAutoLayout() {
        imgViewGameIcon.translatesAutoresizingMaskIntoConstraints = false
        stackViewGameAttribute.translatesAutoresizingMaskIntoConstraints = false
        imgViewFavorite.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelGenre.translatesAutoresizingMaskIntoConstraints = false
        stackViewRating.translatesAutoresizingMaskIntoConstraints = false
        labelRating.translatesAutoresizingMaskIntoConstraints = false
        imgViewRating.translatesAutoresizingMaskIntoConstraints = false
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacerRating.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgViewGameIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imgViewGameIcon.widthAnchor.constraint(equalToConstant: 64),
            imgViewGameIcon.heightAnchor.constraint(equalTo: imgViewGameIcon.widthAnchor),
            imgViewGameIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackViewGameAttribute.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackViewGameAttribute.leadingAnchor.constraint(equalTo: imgViewGameIcon.trailingAnchor, constant: 20),
            stackViewGameAttribute.trailingAnchor.constraint(equalTo: imgViewFavorite.leadingAnchor, constant: -20),
            stackViewGameAttribute.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            imgViewFavorite.centerYAnchor.constraint(equalTo: centerYAnchor),
            imgViewFavorite.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imgViewFavorite.widthAnchor.constraint(equalToConstant: 16),
            imgViewFavorite.heightAnchor.constraint(equalTo: imgViewFavorite.widthAnchor),
            
            spacer.heightAnchor.constraint(equalToConstant: 5),
            spacerRating.widthAnchor.constraint(equalToConstant: 10),
            
            imgViewRating.widthAnchor.constraint(equalToConstant: 12),
            imgViewRating.heightAnchor.constraint(equalTo: imgViewRating.widthAnchor)
        ])
    }
    
    private func loadGameImage(imageUrl: String?) {
        imgViewGameIcon.image = nil
        guard let imageUrl = imageUrl else {
            self.imgViewGameIcon.image = UIImage(systemName: "xmark.octagon")
            return
        }
        Service.loadImage(imageUrl: imageUrl) { [weak self] img in
            guard let self = self else { return }
            let img = img ?? UIImage(systemName: "xmark.octagon")
            DispatchQueue.main.async {
                self.imgViewGameIcon.image = img
            }
        }
    }
    
    // MARK: Public Function
    func initValue(game: Game) {
        labelName.text = game.name
        labelGenre.text = game.genres.joined(separator: " . ")
        labelRating.text = "\(game.rating)"
        labelReleaseDate.text = game.released ?? ""
        loadGameImage(imageUrl: game.backgroundImage)
        imgViewFavorite.isHidden = true
    }
    
    func initValueFavorite(cdgame: CDGame) {
        let genres = cdgame.genres ?? []
        labelName.text = cdgame.name
        labelGenre.text = genres.joined(separator: " . ")
        labelRating.text = "\(cdgame.rating)"
        labelReleaseDate.text = cdgame.released ?? ""
        loadGameImage(imageUrl: cdgame.backgroundImage)
        imgViewFavorite.isHidden = false
    }
}
