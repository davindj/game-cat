//
//  GameDetailRatingView.swift
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

class GameDetailRatingView: UIView {
    private let labelSubHeaderRatings: UILabel = UILabel.initLabelSubHeader(text: "Ratings")
    private let labelRatingAverage: UILabel = UILabel.initLabelLargeText(text: "3.5")
    private let labelOutOf5: UILabel = UILabel.initLabelSecondary(text: "out of 5")
    private let progStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    private let progView5Star: UIProgressView = UIProgressView.initProgressView()
    private let progView4Star: UIProgressView = UIProgressView.initProgressView()
    private let progView3Star: UIProgressView = UIProgressView.initProgressView()
    private let progView2Star: UIProgressView = UIProgressView.initProgressView()
    private let progView1Star: UIProgressView = UIProgressView.initProgressView()
    private let imgStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 0
        return stackView
    }()
    private let star5StackView: UIStackView = UIStackView.initStarStackView(nStar: 5)
    private let star4StackView: UIStackView = UIStackView.initStarStackView(nStar: 4)
    private let star3StackView: UIStackView = UIStackView.initStarStackView(nStar: 3)
    private let star2StackView: UIStackView = UIStackView.initStarStackView(nStar: 2)
    private let star1StackView: UIStackView = UIStackView.initStarStackView(nStar: 1)
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
        progView5Star.progress = 0
        progView4Star.progress = 0
        progView3Star.progress = 0
        progView2Star.progress = 0
        progView1Star.progress = 0
    }
    private func configViewHierarchy() {
        addSubview(labelSubHeaderRatings)
        addSubview(labelRatingAverage)
        addSubview(labelOutOf5)
        addSubview(progStarStackView)
        addSubview(imgStarStackView)
        addSubview(labelRatingCount)
        addSubview(labelRatingCountDecoration)
        
        progStarStackView.addArrangedSubview(progView5Star)
        progStarStackView.addArrangedSubview(progView4Star)
        progStarStackView.addArrangedSubview(progView3Star)
        progStarStackView.addArrangedSubview(progView2Star)
        progStarStackView.addArrangedSubview(progView1Star)
        
        imgStarStackView.addArrangedSubview(star5StackView)
        imgStarStackView.addArrangedSubview(star4StackView)
        imgStarStackView.addArrangedSubview(star3StackView)
        imgStarStackView.addArrangedSubview(star2StackView)
        imgStarStackView.addArrangedSubview(star1StackView)
    }
    private func configConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelSubHeaderRatings.translatesAutoresizingMaskIntoConstraints = false
        labelRatingAverage.translatesAutoresizingMaskIntoConstraints = false
        labelOutOf5.translatesAutoresizingMaskIntoConstraints = false
        progStarStackView.translatesAutoresizingMaskIntoConstraints = false
        imgStarStackView.translatesAutoresizingMaskIntoConstraints = false
        labelRatingCount.translatesAutoresizingMaskIntoConstraints = false
        labelRatingCountDecoration.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelSubHeaderRatings.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            labelSubHeaderRatings.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelRatingAverage.topAnchor.constraint(equalTo: labelSubHeaderRatings.bottomAnchor),
            labelRatingAverage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelOutOf5.topAnchor.constraint(equalTo: labelRatingAverage.bottomAnchor),
            labelOutOf5.centerXAnchor.constraint(equalTo: labelRatingAverage.centerXAnchor),
            
            progStarStackView.topAnchor.constraint(equalTo: labelSubHeaderRatings.bottomAnchor, constant: 5),
            progStarStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progStarStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            imgStarStackView.topAnchor.constraint(equalTo: labelSubHeaderRatings.bottomAnchor, constant: 3),
            imgStarStackView.trailingAnchor.constraint(equalTo: progStarStackView.leadingAnchor, constant: -5),
            imgStarStackView.widthAnchor.constraint(equalTo: star5StackView.widthAnchor, multiplier: 1),

            progView5Star.heightAnchor.constraint(equalToConstant: 4),
            progView4Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor, multiplier: 1),
            progView3Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor, multiplier: 1),
            progView2Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor, multiplier: 1),
            progView1Star.heightAnchor.constraint(equalTo: progView5Star.heightAnchor, multiplier: 1),
            
            labelRatingCount.topAnchor.constraint(equalTo: progStarStackView.bottomAnchor, constant: 5),
            labelRatingCount.trailingAnchor.constraint(equalTo: labelRatingCountDecoration.leadingAnchor, constant: -5),
            labelRatingCountDecoration.topAnchor.constraint(equalTo: labelRatingCount.topAnchor),
            labelRatingCountDecoration.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
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
