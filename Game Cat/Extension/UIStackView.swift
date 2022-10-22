//
//  UIStackView.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/10/22.
//

import UIKit

extension UIStackView {
    static func initStarStackView(nStar: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 0
        for _ in 1...nStar {
            let starImgView = UIImageView()
            starImgView.image = UIImage(systemName: "star.fill")
            starImgView.tintColor = .orange
            NSLayoutConstraint.activate([
                starImgView.widthAnchor.constraint(equalToConstant: 9),
                starImgView.heightAnchor.constraint(equalTo: starImgView.widthAnchor)
            ])
            stackView.addArrangedSubview(starImgView)
        }
        return stackView
    }
}
