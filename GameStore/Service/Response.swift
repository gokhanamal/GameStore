//
//  Response.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameResponse]
}

struct GameResponse: Codable {
    let id: Int
    let name: String
    let imageURL: String?
    let description: String?
    let genres: [Genre]
    let metacritic: Int?
    let redditURL: String?
    let website: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "background_image"
        case genres
        case metacritic
        case description
        case redditURL = "reddit_url"
        case website
    }
}

struct Genre: Codable {
    let name: String
}
