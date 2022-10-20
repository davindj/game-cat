//
//  GameDetailStoreView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 20/10/22.
//

import UIKit

class GameDetailStoreView: UIView {
    private let labelSubHeaderAvailableOn: UILabel = UILabel.initLabelSubHeader(text: "Available On")
    private let labelStores: UILabel = UILabel.initLabelPrimary()
    
    override func didMoveToSuperview() {
        configView()
    }
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
    }
    
    private func configDefaultData() {
        labelStores.text = "Loading..."
    }
    
    private func configViewHierarchy() {
        addSubview(labelSubHeaderAvailableOn)
        addSubview(labelStores)
    }
    
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelSubHeaderAvailableOn.translatesAutoresizingMaskIntoConstraints = false
        labelStores.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: labelSubHeaderAvailableOn.topAnchor, constant: -20),
            
            labelSubHeaderAvailableOn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelStores.topAnchor.constraint(equalTo: labelSubHeaderAvailableOn.bottomAnchor),
            labelStores.leadingAnchor.constraint(equalTo: labelSubHeaderAvailableOn.leadingAnchor),
            labelStores.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            self.bottomAnchor.constraint(equalTo: labelStores.bottomAnchor)
        ])
    }
    
    func configValue(stores: [String]) {
        labelStores.text = stores.joined(separator: "\n")
    }
}
