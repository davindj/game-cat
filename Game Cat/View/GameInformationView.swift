//
//  GameInformationView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 09/10/22.
//

import UIKit

class GameInformationView: UIView {
    private let labelDevelopers: UILabel = UILabel.initLabelSecondary(text: "Developer")
    private let labelDevelopersValue: UILabel = UILabel.initLabelPrimary()
    private let labelPublishers: UILabel = UILabel.initLabelSecondary(text: "Publisher")
    private let labelPublishersValue: UILabel = UILabel.initLabelPrimary()
    private let labelReleased: UILabel = UILabel.initLabelSecondary(text: "Released")
    private let labelReleasedValue: UILabel = UILabel.initLabelPrimary()
    private let labelLastUpdate: UILabel = UILabel.initLabelSecondary(text: "Last Update")
    private let labelLastUpdateValue: UILabel = UILabel.initLabelPrimary()

    override func didMoveToSuperview() {
        configView()
    }
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
    }

    private func configDefaultData() {
        displayData(dev: "Loading...", pub: "Loading...", rel: "Loading...", upd: "Loading...")
    }
    
    private func displayData(dev: String, pub: String, rel: String, upd: String) {
        labelDevelopersValue.text = dev
        labelPublishersValue.text = pub
        labelReleasedValue.text = rel
        labelLastUpdateValue.text = upd
    }
    
    private func configViewHierarchy() {
        addSubview(labelDevelopers)
        addSubview(labelDevelopersValue)
        addSubview(labelPublishers)
        addSubview(labelPublishersValue)
        addSubview(labelReleased)
        addSubview(labelReleasedValue)
        addSubview(labelLastUpdate)
        addSubview(labelLastUpdateValue)
    }
    
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelDevelopers.translatesAutoresizingMaskIntoConstraints = false
        labelDevelopersValue.translatesAutoresizingMaskIntoConstraints = false
        labelPublishers.translatesAutoresizingMaskIntoConstraints = false
        labelPublishersValue.translatesAutoresizingMaskIntoConstraints = false
        labelReleased.translatesAutoresizingMaskIntoConstraints = false
        labelReleasedValue.translatesAutoresizingMaskIntoConstraints = false
        labelLastUpdate.translatesAutoresizingMaskIntoConstraints = false
        labelLastUpdateValue.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: labelDevelopers.topAnchor, constant: -20),

            labelDevelopers.widthAnchor.constraint(equalTo: labelLastUpdate.widthAnchor, multiplier: 1),
            labelPublishers.widthAnchor.constraint(equalTo: labelLastUpdate.widthAnchor, multiplier: 1),
            labelReleased.widthAnchor.constraint(equalTo: labelLastUpdate.widthAnchor, multiplier: 1),
            
            labelDevelopers.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelDevelopersValue.topAnchor.constraint(equalTo: labelDevelopers.topAnchor),
            labelDevelopersValue.leadingAnchor.constraint(equalTo: labelDevelopers.trailingAnchor, constant: 20),
            
            labelPublishers.topAnchor.constraint(equalTo: labelDevelopersValue.bottomAnchor),
            labelPublishers.leadingAnchor.constraint(equalTo: labelDevelopers.leadingAnchor),
            labelPublishersValue.topAnchor.constraint(equalTo: labelPublishers.topAnchor),
            labelPublishersValue.leadingAnchor.constraint(equalTo: labelPublishers.trailingAnchor, constant: 20),
            
            labelReleased.topAnchor.constraint(equalTo: labelPublishersValue.bottomAnchor),
            labelReleased.leadingAnchor.constraint(equalTo: labelDevelopers.leadingAnchor),
            labelReleasedValue.topAnchor.constraint(equalTo: labelReleased.topAnchor),
            labelReleasedValue.leadingAnchor.constraint(equalTo: labelReleased.trailingAnchor, constant: 20),
            
            labelLastUpdate.topAnchor.constraint(equalTo: labelReleasedValue.bottomAnchor),
            labelLastUpdate.leadingAnchor.constraint(equalTo: labelDevelopers.leadingAnchor),
            labelLastUpdateValue.topAnchor.constraint(equalTo: labelLastUpdate.topAnchor),
            labelLastUpdateValue.leadingAnchor.constraint(equalTo: labelLastUpdate.trailingAnchor, constant: 20),

            self.bottomAnchor.constraint(equalTo: labelLastUpdateValue.bottomAnchor)
        ])
    }
    
    func configValue(developers: [String], publishers: [String], releasedAt: String?, updatedAt: String?) {
        let developersStr = developers.joined(separator: "\n")
        let publishersStr = publishers.joined(separator: "\n")
        let releasedDateStr = releasedAt ?? "-"
        let updatedDateStr = updatedAt ?? "-"
        displayData(dev: developersStr, pub: publishersStr, rel: releasedDateStr, upd: updatedDateStr)
    }
}
