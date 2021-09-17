//
//  CloseMessagesView.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import TinyConstraints

class CloseMessagesView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
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
}

extension CloseMessagesView {

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
