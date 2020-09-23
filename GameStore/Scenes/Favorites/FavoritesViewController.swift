//
//  FavoritesViewController.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: FavoritesViewModelProtocol?
    
    var favorites = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        updateTitle()
        
        viewModel?.view = self
        messageLabel.text = "There is no favourites found."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getFavorites()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: GameCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GameCell.reuseIdentifier)
    }
    
    private func updateTitle() {
        if favorites.count == 0 {
            navigationItem.title = "Favorites"
            tableView.isHidden = true
        } else {
            navigationItem.title = "Favorites (\(favorites.count))"
            tableView.isHidden = false
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.reuseIdentifier, for: indexPath) as! GameCell
        let game = favorites[indexPath.row]
        cell.setupCell(with: game)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = favorites[indexPath.row]
        viewModel?.selectGame(id: game.id)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let game = favorites[indexPath.row]
            viewModel?.removeFromFavorites(id: game.id)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            updateTitle()
        }
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func handleOutput(_ output: FavoritesOutput) {
        switch output {
        case .showList(let favoriGames):
            favorites = favoriGames
            updateTitle()
            tableView.reloadData()
        }
    }
    
    func navigate(to navigationType: NavigationType) {
        switch navigationType {
        case .gameDetails(let viewModel):
            let viewController = GameDetailsBuilder.make(with: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
