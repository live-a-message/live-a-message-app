//
//  AKLoadingView.swift
//  DesignSystem
//
//  Created by Tales Conrado on 01/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

public class AKLoadingView {
    public var loadingMessage = "Working..."
    public var successMessage = "Done!"
    public var failureMessage = "Error when processing request!"

    let alert = UIAlertController(title: nil, message: "", preferredStyle: .alert)
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))

    public static let shared = AKLoadingView()

    public func setupLoadingMessages(loadingMessage: String, successMessage: String, failureMessage: String) {
        self.loadingMessage = loadingMessage
        self.successMessage = successMessage
        self.failureMessage = failureMessage
    }

    public func startLoading(on controller: UIViewController) {
        alert.message = loadingMessage
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        controller.present(alert, animated: true)
    }

    public func stopLoading(didSucceed: Bool = true) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()

            if didSucceed {
                self.alert.message = self.successMessage
            } else {
                self.alert.message = self.failureMessage
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.alert.dismiss(animated: true)
        }
    }
}
