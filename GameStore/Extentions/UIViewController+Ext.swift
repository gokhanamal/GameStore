//
//  UIViewController+Ext.swift
//  GameStore
//
//  Created by Gokhan Namal on 14.08.2020.
//  Copyright © 2020 Gokhan Namal. All rights reserved.
//

import class UIKit.UIViewController
import class UIKit.UIAlertController
import class UIKit.UIAlertAction

extension UIViewController {
    func showAlert(title: String, message: String?, actions: [UIAlertAction] = []) {
      let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
      if actions.isEmpty {
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(action)
      } else {
        for action in actions {
            vc.addAction(action)
        }
      }
      self.present(vc, animated: true, completion: nil)
    }
}
