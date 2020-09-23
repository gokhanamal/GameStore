//
//  GameDetailsViewModel.swift
//  GameStore
//
//  Created by Gokhan Namal on 12.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

final class GameDetailsViewModel: GameDetailsViewModelProtocol {
    var view: GameDetailsViewProtocol?
    var gameResonse: GameResponse?
    
    var service: ServiceProtocol
    var gameId: Int
    
    init(gameId: Int, service: ServiceProtocol) {
        self.service = service
        self.gameId = gameId
    }
    
    func getGameDetails() {
        view?.handleOutput(.setLoading(true))
        let isFavorited = UserDefaultsStorage.shared.isFavorited(id: gameId)
        view?.handleOutput(.setFavorited(isFavorited))
        
        service.getGame(id: gameId) { [weak self] result in
            guard let `self` = self else { return }
            switch(result) {
            case.failure(let error):
                print(error)
                self.view?.handleOutput(.showError(error.localizedDescription))
            case .success(let gameResonse):
                self.gameResonse = gameResonse
                let game = GameDetails(
                    name: gameResonse.name,
                    imageURL: gameResonse.imageURL,
                    description: gameResonse.description,
                    website: gameResonse.website,
                    redditURL: gameResonse.redditURL
                )
                self.view?.handleOutput(.showGameDetails(game))
                self.view?.handleOutput(.setLoading(false))
            }
        }
    }
    
    func addToFavorite() {
        if let game = gameResonse {
            UserDefaultsStorage.shared.addToFavorite(game: game)
        }
    }
}
