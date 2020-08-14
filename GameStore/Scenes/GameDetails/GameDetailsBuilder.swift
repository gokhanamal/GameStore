//
//  GameDetailsBuilder.swift
//  GameStore
//
//  Created by Gokhan Namal on 12.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

final class GameDetailsBuilder {
    static func make(with viewModel: GameDetailsViewModelProtocol) -> GameDetailsViewController {
        let storyBoard = UIStoryboard(name: "GameDetails", bundle: nil)
        let viewController = storyBoard.instantiateInitialViewController() as! GameDetailsViewController
        
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
}
