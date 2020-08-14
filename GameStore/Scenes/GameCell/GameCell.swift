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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setCell(game: Game) {
        titleLbl.text = game.name
        metaCriticLbl.text = game.metacritic > 0 ? "\(game.metacritic)" : "unknown"
        
        genresLbl.text = game.genre
        imgView.image = UIImage(named: "placeholder")
        imgView?.downloadImage(url: game.url)
        imgView?.contentMode = .scaleAspectFill
        if game.seen {
            backgroundColor = UIColor.Custom.gray
        } else {
            backgroundColor = .white
        }
    }
}
