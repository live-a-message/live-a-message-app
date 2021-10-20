//
//  UIViewController+Alert.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 14/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String) {

    let alertController = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )

    let didConfirmAction = UIAlertAction(title: "OK", style: .default)

    alertController.addAction(didConfirmAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
