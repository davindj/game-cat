//
//  CDGame+CoreDataClass.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/10/22.
//
//

import Foundation
import CoreData

public class CDGame: NSManagedObject {
    static func initFromModel(context: NSManagedObjectContext, game: Game, gameDetail: GameDetail) -> CDGame {
        let ratings: [GameDetailRating] = [
            gameDetail.ratingsStar1,
            gameDetail.ratingsStar2,
            gameDetail.ratingsStar3,
            gameDetail.ratingsStar4,
            gameDetail.ratingsStar5
        ]
        let cdGame = CDGame(context: context)
        cdGame.id = Int64(game.id)
        cdGame.genres = game.genres
        cdGame.name = game.name
        cdGame.backgroundImage = game.backgroundImage
        cdGame.rating = game.rating
        cdGame.released = game.released
        cdGame.descriptionGame = gameDetail.description
        cdGame.developers = gameDetail.developers
        cdGame.publishers = gameDetail.publishers
        cdGame.ratingStarCounts = ratings.map { $0.count }
        cdGame.ratingStarPercentages = ratings.map { $0.percent }
        cdGame.stores = gameDetail.stores
        cdGame.tags = gameDetail.tags
        cdGame.totalRating = Int64(gameDetail.totalRating)
        cdGame.updatedDate = gameDetail.updatedDate
        
        return cdGame
    }
    
    func toGame() -> Game {
        let game = Game(id: Int(self.id),
                        name: self.name ?? "",
                        released: self.released ?? "-",
                        backgroundImage: self.backgroundImage,
                        rating: self.rating,
                        genres: self.genres ?? [])
        return game
    }
    
    func toGameDetail() -> GameDetail {
        var ratingStars: [GameDetailRating] = []
        for index in 0..<5 {
            let count = Int(self.ratingStarCounts?[index] ?? 0)
            let percentage: Double = self.ratingStarPercentages?[index] ?? 0.0
            ratingStars.append(GameDetailRating(count: count, percent: percentage))
        }
        let gameDetail = GameDetail(developers: self.developers ?? [],
                                    publishers: self.publishers ?? [],
                                    updatedDate: self.updatedDate,
                                    description: self.descriptionGame ?? "",
                                    tags: self.tags ?? [],
                                    ratingsStar5: ratingStars[4],
                                    ratingsStar4: ratingStars[3],
                                    ratingsStar3: ratingStars[2],
                                    ratingsStar2: ratingStars[1],
                                    ratingsStar1: ratingStars[0],
                                    totalRating: Int(self.totalRating),
                                    stores: self.stores ?? [])
        return gameDetail
    }
    
    public static func fetchRequestByGameId(gameId: Int64) -> NSFetchRequest<CDGame> {
        let fetchReq = CDGame.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", gameId)
        fetchReq.predicate = predicate
        return fetchReq
    }
}
