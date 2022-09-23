//
//  GameDetail.swift
//  Game Cat
//
//  Created by Davin Djayadi on 23/09/22.
//

import Foundation

struct GameDetail {
    let developers: [String]
    let publishers: [String]
    let updatedDate: String?
    let description: String
    let tags: [String]
    let ratingsStar5: GameDetailRating
    let ratingsStar4: GameDetailRating
    let ratingsStar3: GameDetailRating
    let ratingsStar2: GameDetailRating
    let ratingsStar1: GameDetailRating
    let totalRating: Int
    let stores: [String]
}

struct GameDetailRating {
    let count: Int
    let percent: Double
}
