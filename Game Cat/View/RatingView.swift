//
//  RatingView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/09/22.
//

import UIKit

struct RatingPercentage {
    let starPercentage5: Float
    let starPercentage4: Float
    let starPercentage3: Float
    let starPercentage2: Float
    let starPercentage1: Float
}

class RatingView: UIView {
    private let labelSubHeaderRatings: UILabel = UILabel.initLabelSubHeader(text: "Ratings")
    private let labelRatingAverage: UILabel = UILabel.initLabelLargeText(text: "3.5")
    private let labelOutOf5: UILabel = UILabel.initLabelSecondary(text: "out of 5")
    private let progView5Star: UIProgressView = UIProgressView.initProgressView()
    private let progView4Star: UIProgressView = UIProgressView.initProgressView()
    private let progView3Star: UIProgressView = UIProgressView.initProgressView()
    private let progView2Star: UIProgressView = UIProgressView.initProgressView()
    private let progView1Star: UIProgressView = UIProgressView.initProgressView()
    private let labelRatingCount: UILabel = UILabel.initLabelPrimary(text: "3.5")
    private let labelRatingCountDecoration: UILabel = UILabel.initLabelSecondary(text: "Ratings")
    
    override func didMoveToSuperview() {
        configView()
    }
    private func configView() {
        configDefaultData()
        configViewHierarchy()
        configConstraints()
    }
    private func configDefaultData() {
        print("config default data")
    }
    private func configViewHierarchy() {
        addSubview(labelSubHeaderRatings)
        addSubview(labelRatingAverage)
        addSubview(labelOutOf5)
        addSubview(progView5Star)
        addSubview(progView4Star)
        addSubview(progView3Star)
        addSubview(progView2Star)
        addSubview(progView1Star)
        addSubview(labelRatingCount)
        addSubview(labelRatingCountDecoration)
    }
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelSubHeaderRatings.translatesAutoresizingMaskIntoConstraints = false
        labelRatingAverage.translatesAutoresizingMaskIntoConstraints = false
        labelOutOf5.translatesAutoresizingMaskIntoConstraints = false
        progView5Star.translatesAutoresizingMaskIntoConstraints = false
        progView4Star.translatesAutoresizingMaskIntoConstraints = false
        progView3Star.translatesAutoresizingMaskIntoConstraints = false
        progView2Star.translatesAutoresizingMaskIntoConstraints = false
        progView1Star.translatesAutoresizingMaskIntoConstraints = false
        labelRatingCount.translatesAutoresizingMaskIntoConstraints = false
        labelRatingCountDecoration.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelSubHeaderRatings.topAnchor.constraint(equalTo: topAnchor),
            labelSubHeaderRatings.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelRatingAverage.topAnchor.constraint(equalTo: labelSubHeaderRatings.bottomAnchor),
            labelRatingAverage.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelOutOf5.topAnchor.constraint(equalTo: labelRatingAverage.bottomAnchor),
            labelOutOf5.centerXAnchor.constraint(equalTo: labelRatingAverage.centerXAnchor),
            
            progView4Star.widthAnchor.constraint(equalTo: progView5Star.widthAnchor),
            progView3Star.widthAnchor.constraint(equalTo: progView5Star.widthAnchor),
            progView2Star.widthAnchor.constraint(equalTo: progView5Star.widthAnchor),
            progView1Star.widthAnchor.constraint(equalTo: progView5Star.widthAnchor),
            progView4Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor),
            progView3Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor),
            progView2Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor),
            progView1Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor),
            progView4Star.trailingAnchor.constraint(equalTo: progView5Star.trailingAnchor),
            progView3Star.trailingAnchor.constraint(equalTo: progView5Star.trailingAnchor),
            progView2Star.trailingAnchor.constraint(equalTo: progView5Star.trailingAnchor),
            progView1Star.trailingAnchor.constraint(equalTo: progView5Star.trailingAnchor),

            progView5Star.topAnchor.constraint(equalTo: labelSubHeaderRatings.bottomAnchor, constant: 5),
            progView5Star.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            progView5Star.heightAnchor.constraint(equalToConstant: 4),
            progView5Star.trailingAnchor.constraint(equalTo: trailingAnchor),
            progView4Star.topAnchor.constraint(equalTo: progView5Star.bottomAnchor, constant: 5),
            progView3Star.topAnchor.constraint(equalTo: progView4Star.bottomAnchor, constant: 5),
            progView2Star.topAnchor.constraint(equalTo: progView3Star.bottomAnchor, constant: 5),
            progView1Star.topAnchor.constraint(equalTo: progView2Star.bottomAnchor, constant: 5),
            
            labelRatingCount.topAnchor.constraint(equalTo: progView1Star.bottomAnchor, constant: 5),
            labelRatingCount.trailingAnchor.constraint(equalTo: labelRatingCountDecoration.leadingAnchor, constant: -5),
            labelRatingCountDecoration.topAnchor.constraint(equalTo: labelRatingCount.topAnchor),
            labelRatingCountDecoration.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomAnchor.constraint(equalTo: labelOutOf5.bottomAnchor)
        ])
    }
    
    func configValue(ratingAvg: Double, ratingCount: Int, ratingPerc: RatingPercentage) {
        labelRatingAverage.text = String(NSString(format: "%.1f", ratingAvg))
        labelRatingCount.text = "\(ratingCount)"
        progView5Star.progress = ratingPerc.starPercentage5
        progView4Star.progress = ratingPerc.starPercentage4
        progView3Star.progress = ratingPerc.starPercentage3
        progView2Star.progress = ratingPerc.starPercentage2
        progView1Star.progress = ratingPerc.starPercentage1
    }
}
