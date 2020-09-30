//
//  GameStoreViewModel.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

final class GamesViewModel: GamesViewModelProtocol {
    
    
    weak var view: GamesViewProtocol?
    var service: ServiceProtocol
    
    private var nextPage: String?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func searchGames(query: String?) {
        if let query = query, query.count > 2 {
            view?.handleOutput(.setLoading(true))
            service.getGames(next: nextPage, query: query) { [weak self] result in
                guard let `self` = self else {return}
                self.handleGamesResult(result: result)
            }
        } else {
            view?.handleOutput(.showMessage("No game has been searched."))
        }
    }
    
    func selectGame(id: Int) {
        let service = GameStoreService()
        let viewModel = GameDetailsViewModel(gameId: id, service: service)
        
        UserDefaultsStorage.shared.setSeen(id: id)
        view?.navigate(to: .gameDetails(viewModel))
    }
    
    func handleGamesResult(result: Result<GamesResponse, Error>) {
        switch(result) {
        case .success(let response):
            let games = response.results.map{
               Game(
                   id: $0.id,
                   name: $0.name,
                   imageURL: $0.imageURL,
                   genre: $0.genres.map({$0.name}).joined(separator: ", "),
                   metacritic: $0.metacritic ?? 0,
                   seen: UserDefaultsStorage.shared.isSeen(id: $0.id)
               )
            }
            
            if games.count < 1 {
                view?.handleOutput(.showMessage("There is no games found."))
            } else {
                nextPage = response.next
                let isFirstPage = response.previous == nil
                if isFirstPage {
                    view?.handleOutput(.showGameList(games))
                } else {
                    view?.handleOutput(.loadMore(games))
                }
                view?.handleOutput(.setLoading(false))
            }
        case .failure(let error):
            self.view?.handleOutput(.showError(error.localizedDescription))
            view?.handleOutput(.setLoading(false))
        }
    }
}
