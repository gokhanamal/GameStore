//
//  GameDetailsContracts.swift
//  GameStore
//
//  Created by Gokhan Namal on 12.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

protocol GameDetailsViewModelProtocol {
    var view: GameDetailsViewProtocol? {get set}
    func getGameDetails()
    func addToFavorite()
}

protocol GameDetailsViewProtocol {
    func handleOutput(_ output: GameDetailsOutputs)
}

enum GameDetailsOutputs {
    case showError(String)
    case setLoading(Bool)
    case showGameDetails(GameDetails)
    case setFavorited(Bool)
}

struct GameDetails {
    let name: String
    let imageURL: String?
    let description: String?
    let website: String?
    let redditURL: String?
}
