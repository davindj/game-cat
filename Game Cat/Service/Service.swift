//
//  Network.swift
//  Game Cat
//
//  Created by Davin Djayadi on 21/09/22.
//

import UIKit

struct Service {
    private static let HOST = "https://api.rawg.io"
    private static let APIKEY = "your_apikey"
    static func getGames(callback: @escaping([Game], ServiceGetAllDataErrorStatus?) -> Void) {
        guard var components = URLComponents(string: "\(HOST)/api/games") else { return }
        components.queryItems = [
            URLQueryItem(name: "key", value: APIKEY)
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
        if let gamesPayload = try? decoder.decode(ServicePayloadGetGames.self, from: data) {
            return gamesPayload
        }
        return nil
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
}
