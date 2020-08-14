//
//  GameStoreService.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation

final class GameStoreService: ServiceProtocol {
    enum Endpoints {
        
        case games(String?)
        case game(Int)
        
        private var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.rawg.io"
            switch self {
                case .games(let query):
                    components.path = "/api/games"
                    
                    if let query = query {
                        let query = URLQueryItem(name: "search", value: query)
                        components.queryItems = [query]
                    }
                    return components
                case .game(let id):
                    components.path = "/api/games/\(id)"
                return components
            }
        }
        
        var url: URL? {
            self.urlComponents.url
        }
    }
    
    func getGames(next: String?, query: String?, completion: @escaping (Result<GamesResponse, Error>) -> Void) {
        var url: URL?
        
        if let next = next {
            url = URL(string: next)
        } else {
            url = Endpoints.games(query).url
        }
        
        guard let requestURL = url else {return}
        
        makeGetRequest(with: requestURL, resposeType: GamesResponse.self) { result in
            completion(result)
        }
    }
    
    func getGame(id: Int, completion: @escaping (Result<GameResponse, Error>) -> Void) {
        guard let url = Endpoints.game(id).url else { return }
        print(url)
        makeGetRequest(with: url, resposeType: GameResponse.self) { result in
            completion(result)
        }
    }
    
    func makeGetRequest<T: Decodable>(with url: URL, resposeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url){(data, _, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(ServiceErrors.networkError(message: "Failed to get data")))
                    }
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(resposeType, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
