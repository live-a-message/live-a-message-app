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
    private let viewModel: ProfileViewModelProtocol = ProfileViewModel()

    weak var coordinator: Coordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.bind(sections: viewModel.sections)
        contentView.tableView.didSelectRowAt = { self.route(with: $0.type) }
    }

    override func loadView() {
        view = contentView
    }

    private func doLogoff() {
        coordinator?.doLogoff()
    }

    private func route(with type: ProfileItemType) {
        switch type {
        case .termsOfService:
            self.coordinator?.showTermsOfService()
        case .logout:
            self.coordinator?.doLogoff()
        }
    }
}
