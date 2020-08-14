//
//  GameStoreServiceMock.swift
//  GameStoreTests
//
//  Created by Gokhan Namal on 14.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation


final class GameStoreServiceMock: ServiceProtocol {
    func getGames(next: String?, query: String?, completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        let fake = GamesResponse.fake()
        completion(.success(fake))
    }
    
    func getGame(id: Int, completion: @escaping (Result<GameResponse, Error>) -> Void) {
        let fake = GameResponse.fake(id: id)
        completion(.success(fake))
    }
}

extension GameResponse {
    static func fake(id: Int) -> GameResponse {
        return GameResponse(id: id, name: "Need For Speed", imageURL: "https://media.rawg.io/me…6507807a1808595afb12.jpg", description: "Fake", genres: [Genre(name: "Fake")], metacritic: 100, redditURL: nil, website: nil)
    }
}

extension GamesResponse {
    static func fake() -> GamesResponse {
        return GamesResponse(count: 1, next: nil, previous: nil, results: [GameResponse.fake(id: 1)])
    }
}

extension Game {
    static func fake() -> Game {
        let fakeResponse = GameResponse.fake(id: 1)
        return Game(
            id: fakeResponse.id,
            name: fakeResponse.name,
            imageURL: fakeResponse.imageURL,
            genre: fakeResponse.genres.map({$0.name}).joined(separator: ", "),
            metacritic: fakeResponse.metacritic ?? 0,
            seen: false
        )
    }
}
