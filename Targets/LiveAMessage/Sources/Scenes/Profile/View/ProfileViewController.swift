//
//  ProfileViewController.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import Networking

class ProfileViewController: UIViewController {
    private let contentView = ProfileView()
    private var viewModel: ProfileViewModelProtocol = ProfileViewModel()
    private let appVersion = AkeeStrings.lblVersion + " 2.0.0"

    weak var coordinator: Coordinator?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSections()
        contentView.tableView.bind(sections: viewModel.sections)
        contentView.tableView.isScrollEnabled = UserData.shared.isLoggedIn
        contentView.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.didSelectRowAt = { self.route(with: $0.type) }
//        viewModel.emptyState.button = .init(
//            action: { self.didSelectSessionButton() },
//            title: AkeeStrings.btnPrimaryButton)
//        contentView.tableView.emptyStateView = AKEmptyState(style: .viewModel(viewModel.emptyState))
        navigationController?.title = AkeeStrings.navTitleProfile
        contentView.versionLabel.text = appVersion
        navigationController?.navigationBar.topItem?.rightBarButtonItem = buildItem()
    }

    override func loadView() {
        view = contentView
    }

    private func doLogoff() {
        coordinator?.doLogoff()
    }

    private func didSelectSessionButton() {
        coordinator?.presentLogin()
    }

    private func route(with type: ProfileItemType) {
        switch type {
        case .termsOfService:
            guard let nav = navigationController else { return }
            self.coordinator?.showTermsOfService(.push(nav: nav))
        case .logout:
            self.coordinator?.doLogoff()
        case .blockedUsers:
            self.coordinator?.showBlockedUsers()
        default:
            break
        }
    }

    @objc func didTapEditButton() {
        self.route(with: .edit)
    }

    func buildItem() -> UIBarButtonItem? {
        guard UserData.shared.isLoggedIn else { return nil }
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
        button.tintColor = AKColor.red
        return button
    }
}
