//
//  MessageDetailsViewController.swift
//  Akee
//
//  Created by Albert on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class MessageDetailsViewController: UIViewController {

    var viewModel: MessageDetailsViewModelProtocol
    weak var coordinator: Coordinator?
    
    var didCloseDetails: (() -> Void)?

    init(viewModel: MessageDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        let messageView = MessageDetailsView()
        messageView.tableView.delegate = viewModel
        messageView.tableView.dataSource = viewModel
        messageView.tableView.register(MessageDetailMapTableViewCell.self, forCellReuseIdentifier: "MapCell")
        messageView.tableView.register(MessageDetailTableViewCell.self, forCellReuseIdentifier: "MessageCell")
        view = messageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = AKColor.mainRed
        viewModel.readMessage()
        if viewModel.canDelete {
            let barButtonItem = UIBarButtonItem(
                title: AkeeStrings.btnDelete,
                style: .plain,
                target: self,
                action: #selector(showDeleteMenu)
            )
            navigationItem.rightBarButtonItem = barButtonItem
        } else {
            let barButtonItem = UIBarButtonItem(
                title: AkeeStrings.btnReport,
                style: .plain,
                target: self,
                action: #selector(showReportMenu)
            )
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }

    func setCloseButton() {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: IconNamed.close.rawValue),
            style: .plain,
            target: self,
            action: #selector(close)
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc private func showReportMenu() {
        let message = viewModel.message
        coordinator?.showReportMenu(with: message, on: self)
    }

    @objc private func showDeleteMenu() {
        let message = viewModel.message
        coordinator?.showDeleteMenu(with: message, on: self)
    }

    @objc private func close() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
