//
//  PersistentContainer.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/10/22.
//

import CoreData

enum PersistentContainerSaveContextError: Error {
    case failedToSaveContext
}

enum PersistentContainerDeleteGameError: Error {
    case gameNotFound
}

class PersistentContainer: NSPersistentContainer {
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) throws {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
            throw PersistentContainerSaveContextError.failedToSaveContext
        }
    }
    
    func getGames() throws -> [CDGame] {
        let games = try viewContext.fetch(CDGame.fetchRequest())
        return games
    }
    
    func saveGame(game: Game, detail: GameDetail) throws {
        _ = CDGame.initFromModel(context: self.viewContext, game: game, gameDetail: detail)
        try saveContext()
    }
    
    func deleteGame(gameId: Int64) throws {
        let fetchReq = CDGame.fetchRequestByGameId(gameId: gameId)
        let deletedGames = try viewContext.fetch(fetchReq)
        if deletedGames.isEmpty {
            throw PersistentContainerDeleteGameError.gameNotFound
        }
        for delGame in deletedGames {
            viewContext.delete(delGame)
        }
    }
}
