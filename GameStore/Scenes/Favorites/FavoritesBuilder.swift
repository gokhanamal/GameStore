//
//  FavoritesBuilder.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

final class FavoritesBuilder {
    static func make() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! FavoritesViewController
        
        let viewModel = FavoritesViewModel()
        viewController.viewModel = viewModel
        
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
