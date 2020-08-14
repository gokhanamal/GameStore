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
            favorites = result
        }
        
        loadSeen { result in
            seen = result
        }
    }
    
    func addToFavorite(game: GameResponse) {
        if !isFavorited(id: game.id) {
            favorites.append(game)
            saveFavorites()
        }
    }
    
    func loadFavorites(completion: ([GameResponse]) -> Void) {
        do {
            let games = try UserDefaults.standard.getObject(forKey: favoritesKey, castTo: [GameResponse].self)
            completion(games)
        } catch {
            print(error.localizedDescription)
            completion([])
        }
    }
    
    func getFavorites() -> [GameResponse] {
        return favorites
    }
    
    func loadSeen(completion: ([Int: Bool] ) -> Void){
        do {
            let data = try UserDefaults.standard.getObject(forKey: seenKey, castTo: [Int: Bool].self)
            completion(data)
        } catch {
            print(error.localizedDescription)
            completion([Int:Bool]())
        }
    }
    
    func removeFromFavorites(id: Int) {
        favorites = favorites.filter({$0.id != id})
        saveFavorites()
    }
    
    func isFavorited(id: Int) -> Bool {
        let isExist = favorites.first(where: {$0.id == id})
        
        if(isExist == nil) {
            return false
        }
        return true
    }
    
    func saveFavorites() {
        try? UserDefaults.standard.setObject(favorites, forKey: favoritesKey)
    }
    
    func setSeen(id: Int) {
        seen[id] = true
        print(seen)
        saveSeen()
    }
    
    func isSeen(id: Int) -> Bool {
        return seen[id] != nil
    }
    
    func saveSeen() {
        try? UserDefaults.standard.setObject(seen, forKey: seenKey)
    }
}
