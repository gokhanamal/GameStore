//
//  USerDefaultStorage.swift
//  GameStore
//
//  Created by Gokhan Namal on 13.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

final class UserDefaultsStorage {

    let favoritesKey = "favorities"
    let seenKey = "seen"
    
    var favorites = [GameResponse]()
    var seen = [Int: Bool]()
    
    static let shared = UserDefaultsStorage()
    
    init() {
        loadFavorites { result in
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        loadSeen { result in
            switch result {
            case .success(let seen):
                self.seen = seen
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addToFavorite(game: GameResponse) {
        if !isFavorited(id: game.id) {
            favorites.append(game)
            saveFavorites()
        }
    }
    
    func loadFavorites(completion: (Result<[GameResponse], Error>) -> Void) {
        do {
            let games = try UserDefaults.standard.getObject(forKey: favoritesKey, castTo: [GameResponse].self)
            completion(.success(games))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getFavorites() -> [GameResponse] {
        return favorites
    }
    
    func loadSeen(completion: (Result<[Int: Bool], Error>) -> Void){
        do {
            let data = try UserDefaults.standard.getObject(forKey: seenKey, castTo: [Int: Bool].self)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
    
    func removeFromFavorites(id: Int) {
        favorites = favorites.filter({$0.id != id})
        saveFavorites()
    }
    
    func isFavorited(id: Int) -> Bool {
        if let _ = favorites.first(where: {$0.id == id}) {
            return false
        }
        return true
    }
    
    func saveFavorites() {
        do {
            try UserDefaults.standard.setObject(favorites, forKey: favoritesKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setSeen(id: Int) {
        seen[id] = true
        saveSeen()
    }
    
    func isSeen(id: Int) -> Bool {
        return seen[id] != nil
    }
    
    func saveSeen() {
        do {
            try UserDefaults.standard.setObject(seen, forKey: seenKey)
        } catch {
            print(error.localizedDescription)
        }
    }
}
