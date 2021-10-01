//
//  ReportView.swift
//  Akee
//
//  Created by Tales Conrado on 30/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

class ReportView {
    private let viewModel: ReportViewModel

    init(viewModel: ReportViewModel) {
        self.viewModel = viewModel
    }

    func showReportMenu(on viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Report", style: .default) { _ in
            print("User click report button")
        })

        alert.addAction(UIAlertAction(title: "Block user", style: .destructive) { _ in
            print("User click block button")
        })

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            print("User click dismiss button")
        })

        viewController.present(alert, animated: true)
    }
}
