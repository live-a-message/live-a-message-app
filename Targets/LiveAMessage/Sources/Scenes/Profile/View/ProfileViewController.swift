//
//  ProfileViewController.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class ProfileViewController: UIViewController {
    private let contentView = ProfileView()
    private var viewModel: ProfileViewModelProtocol = ProfileViewModel()

    weak var coordinator: Coordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.bind(sections: viewModel.sections)
        contentView.tableView.didSelectRowAt = { self.route(with: $0.type) }
        viewModel.emptyState.button = .init(
            action: { self.didSelectSessionButton() },
            title: "Iniciar Sessão")
        contentView.tableView.emptyStateView = AKEmptyState(style: .viewModel(viewModel.emptyState))
        navigationController?.title = AkeeStrings.navTitleProfile
    }

    override func loadView() {
        view = contentView
    }

    private func doLogoff() {
        coordinator?.doLogoff()
    }

    private func didSelectSessionButton() {
        print("@Not Implemented: Iniciar Sessão")
    }

    private func route(with type: ProfileItemType) {
        switch type {
        case .termsOfService:
            guard let nav = navigationController else { return }
            self.coordinator?.showTermsOfService(.push(nav: nav))
        case .logout:
            self.coordinator?.doLogoff()
        default:
            break
        }
    }
}
