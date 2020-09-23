//
//  GameDetailsViewController.swift
//  GameStore
//
//  Created by Gokhan Namal on 12.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import SVProgressHUD
import UIKit

final class GameDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var redditButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: GameDetailsViewModelProtocol? {
        didSet {
            viewModel?.view = self
        }
    }
    var isFavorited = false
    var game: GameDetails?
    
    override func viewDidLoad() {
        setupNavigation()
        setupGradient()

        viewModel?.getGameDetails()
    }
    
    private func setupNavigation() {
        tabBarController?.tabBar.isHidden = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.1).cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: imageView.frame.size.width, height: imageView.frame.size.height)
        
        imageView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupBarButton(isFavorited: Bool) {
        self.isFavorited = isFavorited
        let buttonText = isFavorited ? "Favorited" : "Favorite"
        let button = UIBarButtonItem(title: buttonText, style: .plain, target: self, action: #selector(addFavorite(_:)))
        button.isEnabled = !isFavorited
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func addFavorite(_ sender: UIButton) {
        viewModel?.addToFavorite()
        setupBarButton(isFavorited: true)
    }
    
    @IBAction func onPressVisitWebsite(_ sender: Any) {
        if let redditURL = game?.redditURL, let url = URL(string: redditURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func onPressVisitReddit(_ sender: Any) {
        if let website = game?.website, let url = URL(string: website) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension GameDetailsViewController: GameDetailsViewProtocol {
    func handleOutput(_ output: GameDetailsOutputs) {
        switch output {
        case .setLoading(let isLoading):
            setLoading(isLoading)
        case .showError(let error):
            self.showAlert(title: "Error!", message: error)
        case .showGameDetails(let gameDetails):
            handeShowGameDetails(gameDetails: gameDetails)
        case .setFavorited(let isFavorited):
            setupBarButton(isFavorited: isFavorited)
        }
    }
    
    private func setLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.isHidden = false
            stackView.isHidden = true
        } else {
            activityIndicator.isHidden = true
            stackView.isHidden = false
        }
    }
    private func removeHTMLTagsFromString(text: String?) -> String? {
        return text?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    private func handeShowGameDetails(gameDetails: GameDetails) {
        imageView.image = UIImage(named: "placeholder")
        imageView.downloadImage(url: gameDetails.url)
        titleLabel.text = gameDetails.name
        descLabel.text = removeHTMLTagsFromString(text: gameDetails.description)
        
        if gameDetails.website == nil || gameDetails.website == "" {
            websiteButton.isHidden = true
        }
        if gameDetails.redditURL == nil || gameDetails.redditURL == "" {
            redditButton.isHidden = true
        }
        
        self.game = gameDetails
    }
}
