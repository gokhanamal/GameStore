//
//  GamesContracts.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

protocol GamesViewModelProtocol {
    var view: GamesViewProtocol? {get set}
    func searchGames(query: String?)
    func selectGame(id: Int)
}

protocol GamesViewProtocol: class {
    func handleOutput(_ output: GamesViewModelOutput)
    func navigate(to navigationType: NavigationType)
}

enum GamesViewModelOutput: Equatable {
    case showGameList([Game])
    case loadMore([Game])
    case setLoading(Bool)
    case showError(String)
    case showMessage(String)
}

struct Game {
    let id: Int
    let name: String
    let imageURL: String?
    let genre: String
    let metacritic: Int
    var seen: Bool
}

enum NavigationType {
    case gameDetails(GameDetailsViewModelProtocol)
}

extension GamesViewModelOutput {
    static func == (lhs: GamesViewModelOutput, rhs: GamesViewModelOutput) -> Bool {
        return true
    }
}
