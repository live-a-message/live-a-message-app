//
//  CloseMessagesView.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints

class CloseMessagesView: UIView {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: AkeeStrings.refreshCloseMessages)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        return refreshControl
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        return tableView
    }()

    lazy var closeButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.image = UIImage(systemName: IconNamed.close.rawValue)
        barButtonItem.tintColor = AKColor.mainRed
        return barButtonItem
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func bind(viewModel: CloseMessagesViewModelProtocol) {
        for section in viewModel.sections {
            for cell in section {
                tableView.register(
                    CloseMessageTableViewCell.self,
                    forCellReuseIdentifier: cell.identifier
                )
            }
        }

        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }

    func reloadData() {
        tableView.reloadData()
    }

    @objc private func refresh() {
        reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }
}

extension CloseMessagesView: ViewCode {

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }

    func buildHierarchy() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.edgesToSuperview()
    }
}
