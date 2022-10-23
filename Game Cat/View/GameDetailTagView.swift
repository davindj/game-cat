//
//  GameDetailTagView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 20/10/22.
//

import UIKit

class GameDetailTagView: UIView {
    private let labelSubHeaderTags: UILabel = UILabel.initLabelSubHeader(text: "Tags")
    private let labelTags: UILabel = UILabel.initLabelPrimary()
    
    override func didMoveToSuperview() {
        configView()
    }
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
    }
    
    private func configDefaultData() {
        labelTags.text = "Loading..."
    }
    
    private func configViewHierarchy() {
        addSubview(labelSubHeaderTags)
        addSubview(labelTags)
    }
    
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelSubHeaderTags.translatesAutoresizingMaskIntoConstraints = false
        labelTags.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: labelSubHeaderTags.topAnchor, constant: -20),
            labelSubHeaderTags.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelTags.topAnchor.constraint(equalTo: labelSubHeaderTags.bottomAnchor),
            labelTags.leadingAnchor.constraint(equalTo: labelSubHeaderTags.leadingAnchor),
            labelTags.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            self.bottomAnchor.constraint(equalTo: labelTags.bottomAnchor)
        ])
    }
    
    func configValue(tags: [String]) {
        labelTags.text = tags.isEmpty ? "-" : tags.joined(separator: " . ")
    }
}
