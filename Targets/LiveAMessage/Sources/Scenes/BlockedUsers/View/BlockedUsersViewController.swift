//
//  BlockedUsersViewController.swift
//  Akee
//
//  Created by Vinicius Mesquita on 02/12/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class BlockedUsersViewController: UIViewController {
    let tableView: AKTableView = { AKTableView<BlockedUsersCellViewModel, BlockedUsersCellView>() }()
    let loadingIndicator: AKLoadingIndicator = { AKLoadingIndicator(frame: .zero) }()
    var viewModel: BlockedUserViewModelProtocol = BlockedUsersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.set(.load)
        configureViews()
        self.title = "Blocked Users"
        tableView.backgroundView?.backgroundColor = .white
        tableView.emptyStateView = AKEmptyState(style: .generic)

        viewModel.didUpdateDataSource = { DispatchQueue.main.async {
            self.tableView.bind(sections: self.viewModel.sections)
            self.loadingIndicator.set(.stop)
        }}

        viewModel.delegate = self
        tableView.didSelectRowAt = { [weak self] blockedUserViewModel in
            guard let self = self else { return }
            self.showUnblockUserAlert(id: blockedUserViewModel.user.id)
        }
    }

    private func configureViews() {
        navigationController?.navigationBar.tintColor = AKColor.mainRed
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        tableView.contentInset = UIEdgeInsets.top(AKSpacing.medium.value)
        tableView.separatorStyle = .none
        loadingIndicator.centerInSuperview()
        tableView.edgesToSuperview()
    }

    private func showUnblockUserAlert(id: String) {
        let alertModel = AlertModel(
            title: "Unblock user",
            message: "You will be able to see all the messages posted by this user",
            firstButton: "cancel",
            firstAction: { [weak self] in
                self?.tableView.deselectSelectedRow(animated: true)
            },
            secondButton: "unblock",
            secondAction: { [weak self] in
                guard let self = self else { return }
                self.viewModel.unblockUser(id: id)
                AKLoadingView.shared.startLoading(on: self)
            }
        )
        showAlert(model: alertModel)
    }
}

extension BlockedUsersViewController: BlockedUserViewModelDelegate {
    func unblockedUserFailure() {
        AKLoadingView.shared.stopLoading(didSucceed: false)
    }
    func unblockedUserSuccess() {
        self.viewModel.sections = [[]]
        self.tableView.bind(sections: self.viewModel.sections)
        AKLoadingView.shared.stopLoading(didSucceed: true)
    }

    func success() {
        AKLoadingView.shared.stopLoading(didSucceed: true)
    }
    func failure() {
        AKLoadingView.shared.stopLoading(didSucceed: false)
    }
}
