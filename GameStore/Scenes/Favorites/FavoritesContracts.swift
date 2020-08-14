//
//  FavoritesContracts.swift
//  GameStore
//
//  Created by Gokhan Namal on 13.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var view: FavoritesViewProtocol? { get set }
    func getFavorites()
    func selectGame(id: Int)
    func removeFromFavorites(id: Int)
}

protocol FavoritesViewProtocol: class {
    func handleOutput(_ output: FavoritesOutput)
    func navigate(to navigationType: NavigationType)
}

enum FavoritesOutput {
    case showList([Game])
}

