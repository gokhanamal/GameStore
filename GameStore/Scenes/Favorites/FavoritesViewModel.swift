//
//  FavoritesViewModel.swift
//  GameStore
//
//  Created by Gokhan Namal on 13.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

final class FavoritesViewModel: FavoritesViewModelProtocol {
    weak var view: FavoritesViewProtocol?

    func getFavorites() {
        let favotires = UserDefaultsStorage.shared.getFavorites()
        let games = favotires.map {
            Game(
                id: $0.id,
                name: $0.name,
                imageURL: $0.imageURL,
                genre: $0.genres.map({$0.name}).joined(separator: ", "),
                metacritic: $0.metacritic ?? 0,
                seen: false
            )
        }
        view?.handleOutput(.showList(games))
    }
    
    func selectGame(id: Int) {
        let service = GameStoreService()
        let viewModel = GameDetailsViewModel(gameId: id, service: service)
        view?.navigate(to: .gameDetails(viewModel))
    }
    
    func removeFromFavorites(id: Int) {
        UserDefaultsStorage.shared.removeFromFavorites(id: id)
    }
}
