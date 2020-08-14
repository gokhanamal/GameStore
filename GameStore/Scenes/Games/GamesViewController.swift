//
//  MoviesViewController.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit
import SVProgressHUD

final class GamesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: GamesViewModelProtocol?
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupSearchBar()
        setupTableView()
        
        viewModel?.view = self
        
        messageLabel.text = "No game has been searched."
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for the games"
    }
    
    private func setupNavigation() {
        navigationItem.title = "Games"
        tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: GameCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GameCell.reuseIdentifier)
        tableView.isHidden = true
    }
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        cell.setCell(game: games[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == games.count - 1 && games.count > 15 {
            viewModel?.searchGames(query: searchBar.searchTextField.text)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        viewModel?.selectGame(id: game.id)
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.Custom.gray
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GamesViewController: GamesViewProtocol {
    func handleOutput(_ output: GamesViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            isLoading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        case .showError(let error):
            self.showAlert(title: "Error!", message: error, actions: nil)
        case .showGameList(let gameList):
            self.games = gameList
            tableView.isHidden = false
            tableView.reloadData()
        case .loadMore(let gameList):
            self.games += gameList
            tableView.reloadData()
        case .showMessage(let message):
            tableView.isHidden = true
            messageLabel.text = message
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

extension GamesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchGames(query: searchText)
    }
}
