//
//  GameStoreTests.swift
//  GameStoreTests
//
//  Created by Gokhan Namal on 14.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import XCTest
@testable import GameStore

class GamesViewModelTest: XCTestCase {
    private var viewModel: GamesViewModelProtocol!
    private var view: GamesMockView!
    
    override func setUp() {
        let service = GameStoreServiceMock()
        viewModel = GamesViewModel(service: service)
        view = GamesMockView()
        viewModel.view = view
    }
    
    
    func testExample() throws {
        // try with search query less than 3 character
        viewModel.searchGames(query: "Gt")
        
        XCTAssertEqual(view.outputs.count, 1)
        XCTAssertEqual(view.outputs.first, .showMessage("No game has been searched."))
        view.outputs.removeAll()
        
        // try with search query more than 3 character
        viewModel.searchGames(query: "Gta 5")
        
        XCTAssertEqual(view.outputs.count, 3)
        XCTAssertEqual(view.outputs.first, .setLoading(true))
        XCTAssertEqual(view.outputs[1], .showGameList([.fake()]))
        XCTAssertEqual(view.outputs.last, .setLoading(false))
    }
}

private class GamesMockView: GamesViewProtocol {
    func navigate(to navigationType: NavigationType) {
        
    }
    
    var outputs = [GamesViewModelOutput]()
    func handleOutput(_ output: GamesViewModelOutput) {
        outputs.append(output)
    }
}

