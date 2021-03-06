//
//  ProfileCellView.swift
//  Akee
//
//  Created by Vinicius Mesquita on 25/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class ProfileCellView: UITableViewCell, TableViewCell {

    typealias ViewModel = ProfileCellViewModel
    static var identifier: String = String(describing: type(of: self))
    let switchView = UISwitch(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .systemGroupedBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(viewModel: ProfileCellViewModel) {
        self.textLabel?.text = viewModel.title

        if viewModel.type == .anonymous {
            configureSwitchCell()
            switchView.addTarget(
                viewModel,
                action: #selector(viewModel.didTapAnonymousSwitch),
                for: .touchUpInside)
        }

        if viewModel.type == .logout {
            self.accessoryType = .none
            self.accessoryView = nil
            self.textLabel?.textColor = AKColor.red
            self.textLabel?.textAlignment = .center
        }

        if viewModel.type == .allowAR {
            configureSwitchCell()
            self.switchView.isOn = Configuration.shared.allowAR
            switchView.addTarget(
                viewModel,
                action: #selector(viewModel.didTapAllowSwitch),
                for: .touchUpInside)
        }
    }

    func configureSwitchCell() {
        self.switchView.tintColor = AKColor.mainRed
        self.accessoryType = .none
        self.accessoryView?.tintColor = AKColor.mainRed
        self.accessoryView = switchView
    }
}
