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
        configureViews()
        tableView.emptyStateView = AKEmptyState(style: .generic)

        viewModel.didUpdateDataSource = { DispatchQueue.main.async {
            self.loadingIndicator.set(.load)
            self.tableView.bind(sections: self.viewModel.sections)
        }}
    }

    private func configureViews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}
