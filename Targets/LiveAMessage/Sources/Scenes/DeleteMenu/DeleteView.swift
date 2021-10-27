//
//  DeleteView.swift
//  Akee
//
//  Created by Tales Conrado on 07/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import Networking
import DesignSystem
import OSLog

class DeleteView {
    private let viewModel: DeleteViewModel
    var popScreen: ((Message) -> Void)?

    init(viewModel: DeleteViewModel) {
        self.viewModel = viewModel
    }

    func showDeleteMenu(on viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: AkeeStrings.btnDelete, style: .destructive) { _ in
            self.deleteMessage(viewController: viewController)
        })

        alert.addAction(UIAlertAction(title: AkeeStrings.btnCancel, style: .cancel) { _ in
            os_log("User click dismiss button on delete menu")
        })

        viewController.present(alert, animated: true)
    }

    private func deleteMessage(viewController: UIViewController) {
        AKLoadingView.shared.startLoading(on: viewController)
        viewModel.delete { didSucceed in
            AKLoadingView.shared.stopLoading(didSucceed: didSucceed)
            if didSucceed {
                self.popScreen?(self.viewModel.message)
            }
        }
    }
}
