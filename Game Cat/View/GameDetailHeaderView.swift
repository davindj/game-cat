//
//  GameDetailHeaderView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 09/10/22.
//

import UIKit

class GameDetailHeaderView: UIView {
    private let labelGameGenres: UILabel = UILabel.initLabelSecondary()
    private let imgViewGame: UIImageView = UIImageView()
    
    override func didMoveToSuperview() {
        configView()
    }
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
    }
    
    private func configDefaultData() {
        imgViewGame.image = nil
        labelGameGenres.text = "Loading..."
    }
    
    private func configViewHierarchy() {
        addSubview(imgViewGame)
        addSubview(labelGameGenres)
    }
    
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        imgViewGame.translatesAutoresizingMaskIntoConstraints = false
        labelGameGenres.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: imgViewGame.topAnchor, constant: -20),
            imgViewGame.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgViewGame.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgViewGame.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 3.0/4.0),

            labelGameGenres.topAnchor.constraint(equalTo: imgViewGame.bottomAnchor, constant: 20),
            labelGameGenres.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            self.bottomAnchor.constraint(equalTo: labelGameGenres.bottomAnchor)
        ])
    }
    
    func configValue(genres: [String], image: UIImage) {
        imgViewGame.image = image
        labelGameGenres.text = genres.isEmpty ? "-" : genres.joined(separator: " . ")
    }
}
