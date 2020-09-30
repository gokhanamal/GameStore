//
//  GameResponse.swift
//  GameStore
//
//  Created by Gokhan Namal on 30.09.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

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
