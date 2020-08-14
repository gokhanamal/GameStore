//
//  GameStoreServiceTest.swift
//  GameStoreTests
//
//  Created by Gokhan Namal on 14.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import Foundation
import XCTest
@testable import GameStore

class GameStoreServiceTest: XCTestCase {
    var mockService: GameStoreServiceMock!
    
    override func setUp() {
        mockService = GameStoreServiceMock()
    }
    
    func testExample() throws {
        let bundle = Bundle(for: GameStoreServiceTest.self)
        let url = bundle.url(forResource: "game", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let game = try JSONDecoder().decode(GameResponse.self, from: data)
        
        XCTAssertEqual(game.id, 3498)
        XCTAssertEqual(game.name, "Grand Theft Auto V")
        XCTAssertEqual(game.metacritic, 97)
        XCTAssertEqual(game.imageURL, "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg")
        XCTAssertEqual(game.description, "<p>Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. <br />\nSimultaneous storytelling from three unique perspectives: <br />\nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. <br />\nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.</p>")
        
        mockService.getGame(id: 1) { result in
            switch(result) {
                case .success(let gameResponse):
                    XCTAssertEqual(gameResponse.id, 1)
            case .failure(_):
                XCTFail("Failed to testing getGame")
            }
        }
    }
}
