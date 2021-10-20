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
        return refreshControl
    }()

    lazy var tableView: AKTableView<CloseMessageCellViewModel, CloseMessageTableViewCell> = {
        let tableView = AKTableView<CloseMessageCellViewModel, CloseMessageTableViewCell>()
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.emptyStateView = AKEmptyState(style: .generic)
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

    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.33) {
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
