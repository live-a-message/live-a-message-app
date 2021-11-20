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
    private var editingState: Bool = false {
        didSet {
            updateUI()
        }
    }
    weak var coordinator: Coordinator?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSections()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.isScrollEnabled = UserData.shared.isLoggedIn
        contentView.tableView.bind(sections: viewModel.sections)
        contentView.tableView.didSelectRowAt = { self.route(with: $0.type) }
        viewModel.emptyState.button = .init(
            action: { self.didSelectSessionButton() },
            title: AkeeStrings.btnPrimaryButton)
        contentView.tableView.emptyStateView = AKEmptyState(style: .viewModel(viewModel.emptyState))
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
        default:
            break
        }
    }

    @objc
    func allowEdit() {
        self.editingState = true
    }

    @objc
    func disallowEdit() {
        self.editingState = false
        self.contentView.profileView.endEdit()
    }

    func updateUI() {
        self.contentView.profileView.nameLabel.isUserInteractionEnabled = editingState
        if editingState {self.contentView.profileView.nameLabel.becomeFirstResponder()}
        navigationController?.navigationBar.topItem?.rightBarButtonItem = buildItem()
    }

    func buildItem() -> UIBarButtonItem? {
        guard UserData.shared.isLoggedIn else { return nil }
        if editingState {
            let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(disallowEdit))
            button.tintColor = AKColor.red
            return button
        } else {
            let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(allowEdit))
            button.tintColor = AKColor.red
            return button
        }
    }
}
