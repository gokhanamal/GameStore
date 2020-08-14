//
//  UIImageView+Ext.swift
//  GameStore
//
//  Created by Gokhan Namal on 12.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(url: URL?) {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data,response,_ in
           guard let data = data else {
               return
           }
           
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        task.resume()
    }
}
