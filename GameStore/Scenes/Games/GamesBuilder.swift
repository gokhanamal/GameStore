//
//  MoviesBuilder.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

class GamesBuilder {
    static func make() -> UINavigationController {
        // create storyboard instance
        let storyboard = UIStoryboard(name: "Games", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! GamesViewController
        
        // inject dependency
        let service = GameStoreService()
        
        let viewModel = GamesViewModel(service: service)
        viewController.viewModel = viewModel
        
        // setup tab bar item
        let selectedImage = UIImage(named: "games")
        let image = selectedImage?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        viewController.tabBarItem = UITabBarItem(title: "Games", image: image, selectedImage: selectedImage)
        viewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.Colors.darkGray], for: .selected)
        viewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        
        // create navigation controller
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
    
}
