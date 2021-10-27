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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(viewModel: ProfileCellViewModel) {
        self.textLabel?.text = viewModel.title
    }
}
