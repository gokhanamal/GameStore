//
//  UIImageView+Ext.swift
//  GameStore
//
//  Created by Gokhan Namal on 12.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(with url: String?) {
        self.image = UIImage(named: "placeholder")
        
        guard let urlString = url, let url = URL(string: urlString) else { return }
        self.kf.setImage(with: url)
    }
}
