//
//  Network.swift
//  Game Cat
//
//  Created by Davin Djayadi on 21/09/22.
//

import UIKit

struct Service {
    private static let HOST: String = "https://api.rawg.io"
    private static let APIKEY: String = {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "RAWG_API_KEY") as? String else {
            fatalError("Couldn't find key 'RAWG_API_KEY' in 'Info.plist'.")
        }
        return value
    }()
    
    static func getGames(searchText: String, callback: @escaping([Game], ServiceGetAllDataErrorStatus?) -> Void) {
        guard var components = URLComponents(string: "\(HOST)/api/games") else { return }
        components.queryItems = [
            URLQueryItem(name: "key", value: APIKEY),
            URLQueryItem(name: "search", value: searchText)
        ]
        guard let componentUrl = components.url else { return }
        let request = URLRequest(url: componentUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else {
                callback([], .unknown)
                return
            }
            if response.statusCode == 200 {
                guard let payload = decodeGetAllGameJSON(from: data) else {
                    callback([], .unknown)
                    return
                }
                let games = convertPayloadGetGamesToGames(payload: payload)
                callback(games, nil)
                return
            }
            callback([], .unknown)
        }
        task.resume()
    }
    static func getGameDetail(gameId: Int, callback: @escaping(GameDetail?, ServiceGetGameDetailErrorStatus?) -> Void) {
        guard var components = URLComponents(string: "\(HOST)/api/games/\(gameId)") else { return }
        components.queryItems = [
            URLQueryItem(name: "key", value: APIKEY)
        ]
        guard let componentUrl = components.url else { return }
        let request = URLRequest(url: componentUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else {
                callback(nil, .unknown)
                return
            }
            if response.statusCode == 200 {
                guard let payload = decodeGetGameDetailJSON(from: data) else {
                    callback(nil, .unknown)
                    return
                }
                let gameDetail = convertPayloadGameDetailToGameDetail(payload: payload)
                callback(gameDetail, nil)
                return
            }
            callback(nil, .unknown)
        }
        task.resume()
    }
    
    static func loadImage(imageUrl: String, callback: @escaping (UIImage?) -> Void) {
        let keyCache = imageUrl as NSString
        if Cache.isImageCached(key: keyCache) {
            let image = Cache.getImageCache(key: keyCache)
            callback(image)
            return
        }
        guard let url = URL(string: imageUrl) else {
            callback(nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data, !data.isEmpty, let image = UIImage(data: data) {
                Cache.setImageCache(key: keyCache, image: image)
                DispatchQueue.main.async {
                    callback(image)
                }
            } else {
                DispatchQueue.main.async {
                    callback(nil)
                }
            }
        }.resume()
    }
}

// MARK: Helper Function
extension Service {
    private static func decodeGetAllGameJSON(from data: Data) -> ServicePayloadGetGames? {
        let decoder = JSONDecoder()
        do {
            let gamesPayload = try decoder.decode(ServicePayloadGetGames.self, from: data)
            return gamesPayload
        } catch {
            return nil
        }
    }
    private static func convertPayloadGetGamesToGames(payload: ServicePayloadGetGames) -> [Game] {
        var games: [Game] = []
        for gamePayload in payload.results {
            let genres = gamePayload.genres.map { $0.name }
            let game = Game(
                id: gamePayload.id,
                name: gamePayload.name,
                released: gamePayload.released,
                backgroundImage: gamePayload.backgroundImage,
                rating: gamePayload.rating,
                genres: genres)
            games.append(game)
        }
        return games
    }
    private static func decodeGetGameDetailJSON(from data: Data) -> ServicePayloadGetGameDetail? {
        let decoder = JSONDecoder()
        do {
            let gameDetailPayload = try decoder.decode(ServicePayloadGetGameDetail.self, from: data)
            return gameDetailPayload
        } catch {
            print(error)
            return nil
        }
    }
    private static func convertPayloadGameDetailToGameDetail(payload: ServicePayloadGetGameDetail) -> GameDetail {
        let developers = payload.developers.map { $0.name }
        let publishers = payload.publishers.map { $0.name }
        let description = payload.descriptionRaw
            .components(separatedBy: "\r")
            .joined(separator: "")
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
        let tags = payload.tags.map { $0.name }
        var ratingsStar5 = GameDetailRating(count: 0, percent: 0)
        var ratingsStar4 = GameDetailRating(count: 0, percent: 0)
        var ratingsStar3 = GameDetailRating(count: 0, percent: 0)
        var ratingsStar2 = GameDetailRating(count: 0, percent: 0)
        var ratingsStar1 = GameDetailRating(count: 0, percent: 0)
        for ratingsPayload in payload.ratings {
            if ratingsPayload.id == 1 {
                ratingsStar1 = GameDetailRating(count: ratingsPayload.count, percent: ratingsPayload.percent)
            }
            if ratingsPayload.id == 2 {
                ratingsStar2 = GameDetailRating(count: ratingsPayload.count, percent: ratingsPayload.percent)
            }
            if ratingsPayload.id == 3 {
                ratingsStar3 = GameDetailRating(count: ratingsPayload.count, percent: ratingsPayload.percent)
            }
            if ratingsPayload.id == 4 {
                ratingsStar4 = GameDetailRating(count: ratingsPayload.count, percent: ratingsPayload.percent)
            }
            if ratingsPayload.id == 5 {
                ratingsStar5 = GameDetailRating(count: ratingsPayload.count, percent: ratingsPayload.percent)
            }
        }
        let stores = payload.stores.map { $0.store.name }
        let gameDetail = GameDetail(
                developers: developers,
                publishers: publishers,
                updatedDate: payload.updated,
                description: description,
                tags: tags,
                ratingsStar5: ratingsStar5,
                ratingsStar4: ratingsStar4,
                ratingsStar3: ratingsStar3,
                ratingsStar2: ratingsStar2,
                ratingsStar1: ratingsStar1,
                totalRating: payload.ratingsCount,
                stores: stores)

        return gameDetail
    }
}
