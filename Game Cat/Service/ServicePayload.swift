//
//  ServicePayload.swift
//  Game Cat
//
//  Created by Davin Djayadi on 21/09/22.
//

// MARK: - Payload Get Games
struct ServicePayloadGetGames: Codable {
    let results: [ServicePayloadGetGamesResult]
}

struct ServicePayloadGetGamesResult: Codable {
    let id: Int
    let name, released: String
    let backgroundImage: String
    let rating: Double
    let genres: [ServicePayloadGetGamesResultGenre]

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating, genres
    }
}

struct ServicePayloadGetGamesResultGenre: Codable {
    let name: String
}
