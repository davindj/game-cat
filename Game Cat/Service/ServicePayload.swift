//
//  ServicePayload.swift
//  Game Cat
//
//  Created by Davin Djayadi on 21/09/22.
//

// MARK: - Payload Get Games
struct ServicePayloadGetGames: Codable {
    let results: [ServicePayloadGetGames__Result]
}
struct ServicePayloadGetGames__Result: Codable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let genres: [ServicePayloadGetGames__ResultGenre]

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating, genres
    }
}
struct ServicePayloadGetGames__ResultGenre: Codable {
    let name: String
}

// MARK: - Payload Get Game Detail
struct ServicePayloadGetGameDetail: Codable {
    let name, updated: String
    let website: String
    let ratings: [ServicePayloadGetGameDetail__Rating]
    let reviewsTextCount, ratingsCount: Int
    let stores: [ServicePayloadGetGameDetail__StoreElement]
    let developers, tags, publishers: [ServicePayloadGetGameDetail__Developer]
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case name, updated, website, ratings
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case stores, developers, tags, publishers
        case descriptionRaw = "description_raw"
    }
}
struct ServicePayloadGetGameDetail__Developer: Codable {
    let name: String
}
struct ServicePayloadGetGameDetail__Rating: Codable {
    let id, count: Int
    let percent: Double
}
struct ServicePayloadGetGameDetail__StoreElement: Codable {
    let store: ServicePayloadGetGameDetail__StoreStore
}
struct ServicePayloadGetGameDetail__StoreStore: Codable {
    let name, domain: String
}
