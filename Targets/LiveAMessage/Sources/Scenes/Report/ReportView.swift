//
//  ReportView.swift
//  Akee
//
//  Created by Tales Conrado on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import OSLog

class ReportView {
    private let viewModel: ReportViewModel

    init(viewModel: ReportViewModel) {
        self.viewModel = viewModel
    }

    func showReportMenu(on viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: AkeeStrings.btnReport, style: .default) { _ in
            self.reportUser(viewController: viewController)
        })

        alert.addAction(UIAlertAction(title: AkeeStrings.btnBlockUser, style: .destructive) { _ in
            self.blockUser(viewController: viewController)
        })

        alert.addAction(UIAlertAction(title: AkeeStrings.btnCancel, style: .cancel) { _ in
            os_log("User click dismiss button on report menu")
        })

        viewController.present(alert, animated: true)
    }

    private func reportUser(viewController: UIViewController) {
        AKLoadingView.shared.startLoading(on: viewController)
        viewModel.reportUser { didSucceed in
            AKLoadingView.shared.stopLoading(didSucceed: didSucceed)
        }
    }

    private func blockUser(viewController: UIViewController) {
        AKLoadingView.shared.startLoading(on: viewController)
        viewModel.blockUser { didSucceed in
            AKLoadingView.shared.stopLoading(didSucceed: didSucceed)
        }
    }
}
