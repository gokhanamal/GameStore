//
//  ServiceContracts.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func getGames(next: String?, query: String?, completion: @escaping (Result<GamesResponse, Error>) -> Void)
    func getGame(id: Int, completion: @escaping (Result<GameResponse, Error>) -> Void)
}

enum ServiceErrors: Error {
    case networkError(message: String)
}
