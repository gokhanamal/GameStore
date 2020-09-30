//
//  GamesResponse.swift
//  GameStore
//
//  Created by Gokhan Namal on 30.09.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameResponse]
}
