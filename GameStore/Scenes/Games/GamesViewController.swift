//
//  MoviesViewController.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

final class GamesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: GamesViewModelProtocol? {
        didSet {
            viewModel?.view = self
        }
    }
    
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupSearchBar()
        setupTableView()
        setupLabels()
    }
    
    private func setupLabels() {
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
        let game = games[indexPath.row]
        cell.setupCell(with: game)
        
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
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.Colors.gray
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GamesViewController: GamesViewProtocol {
    func handleOutput(_ output: GamesViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            setLoading(isLoading)
        case .showError(let error):
            self.showAlert(title: "Error!", message: error)
        case .showGameList(let gameList):
            self.games = gameList
            tableView.isHidden = false
            tableView.reloadData()
        case .loadMore(let gameList):
            self.games += gameList
            tableView.reloadData()
        case .showMessage(let message):
            showMessage(message: message)
        }
    }
    
    func navigate(to navigationType: NavigationType) {
        switch navigationType {
        case .gameDetails(let viewModel):
            let viewController = GameDetailsBuilder.make(with: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func showMessage(message: String) {
        tableView.isHidden = true
        activityIndicator.isHidden = true
        messageLabel.isHidden = false
        messageLabel.text = message
    }
    
    private func setLoading(_ isLoading: Bool) {
        if isLoading {
            tableView.isHidden = true
            activityIndicator.isHidden = false
            messageLabel.isHidden = true
        } else {
            tableView.isHidden = false
            activityIndicator.isHidden = true
            messageLabel.isHidden = false
        }
    }
}

extension GamesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchGames(query: searchText)
    }
}
