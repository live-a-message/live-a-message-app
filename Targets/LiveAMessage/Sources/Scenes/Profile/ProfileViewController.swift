//
//  ProfileViewController.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    private let contentView = ProfileView()

    weak var coordinator: Coordinator?

    override func loadView() {
        contentView.logoffClosure = doLogoff
        view = contentView
    }

    private func doLogoff() {
        coordinator?.doLogoff()
    }
}
