//
//  GameDetailDescriptionView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 20/10/22.
//

import UIKit

class GameDetailDescriptionView: UIView {
    private let labelGameDescription: UILabel = UILabel.initLabelPrimary()
    
    override func didMoveToSuperview() {
        configView()
    }
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
    }
    
    private func configDefaultData() {
        labelGameDescription.text = "Loading..."
    }
    private func configViewHierarchy() {
        addSubview(labelGameDescription)
    }
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelGameDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: labelGameDescription.topAnchor, constant: -20),
            labelGameDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelGameDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            self.bottomAnchor.constraint(equalTo: labelGameDescription.bottomAnchor)
        ])
    }
    
    func configValue(descriptions: [String]) {
        let desc = descriptions.joined(separator: "\n\n")
        labelGameDescription.text = desc
    }
}
