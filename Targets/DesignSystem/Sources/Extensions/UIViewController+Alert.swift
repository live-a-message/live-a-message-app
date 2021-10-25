//
//  UIViewController+Alert.swift
//  DesignSystem
//
//  Created by Vinicius Mesquita on 14/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public struct AlertModel {
    let title: String
    let message: String
    let firstButton: String
    let firstAction: (() -> Void)
    let secondButton: String?
    let secondAction: (() -> Void)?

    public init(
        title: String,
        message: String,
        firstButton: String,
        firstAction: @escaping (() -> Void),
        secondButton: String? = nil,
        secondAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.firstButton = firstButton
        self.firstAction = firstAction
        self.secondButton = secondButton
        self.secondAction = secondAction
    }
}

extension UIViewController {
    public func showAlert(model: AlertModel) {

        let alertController = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )

        let firstAction = UIAlertAction(title: model.firstButton, style: .default) { _ in
            model.firstAction()
        }

        alertController.addAction(firstAction)

        if let secondButton = model.secondButton {
            let secondAction = UIAlertAction(title: secondButton, style: .default) { _ in
                if model.secondAction == nil {
                    self.dismiss(animated: true)
                } else {
                    model.secondAction?()
                }
            }

            alertController.addAction(secondAction)
        }

        self.present(alertController, animated: true, completion: nil)
  }
}
