//
//  Router.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

class Router {
    static func start() -> UITabBarController {
        let gamesVC = GamesBuilder.make()
        
        
        let favoritesVC = FavoritesBuilder.make()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [gamesVC, favoritesVC]
        return tabBarController
    }
}
