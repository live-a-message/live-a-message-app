//
//  MessageDetailsView.swift
//  Akee
//
//  Created by Albert on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class MessageDetailsView: UIView, ViewCode {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func buildHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.edgesToSuperview()
    }
    
    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }
}
