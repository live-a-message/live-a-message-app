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

    var viewModel: MessageDetailsViewModelProtocol?

    init(viewModel: MessageDetailsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    }

}
