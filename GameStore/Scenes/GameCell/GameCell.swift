//
//  GameCell.swift
//  GameStore
//
//  Created by Gokhan Namal on 11.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

final class GameCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var metaCriticLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    
    static let reuseIdentifier = "GameCell"
    
    func setupCell(with game: Game) {
        titleLbl.text = game.name
        metaCriticLbl.text = game.metacritic > 0 ? "\(game.metacritic)" : "unknown"
        genresLbl.text = game.genre
        
        imgView?.downloadImage(with: game.imageURL)
        imgView?.contentMode = .scaleAspectFill
        
        backgroundColor = game.seen ? UIColor.Colors.gray : .white
    }
}
