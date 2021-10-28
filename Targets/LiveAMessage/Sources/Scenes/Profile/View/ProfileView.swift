//
//  ProfileView.swift
//  DesignSystem
//
//  Created by Tales Conrado on 20/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import TinyConstraints

class ProfileView: UIView, ViewCode {
    lazy var tableView: AKTableView<ProfileCellViewModel, ProfileCellView> = {
        let tableView = AKTableView<ProfileCellViewModel, ProfileCellView>(frame: .zero, style: .grouped)
        tableView.tableHeaderView = UserProfileInfoView()
        tableView.heightForHeaderView = AKSpacing.xxxLarge.value + (2 * AKSpacing.small.value)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildHierarchy() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.edgesToSuperview()
    }

    func configureViews() {
        backgroundColor = AKColor.mainBackgroundColor
    }
}
