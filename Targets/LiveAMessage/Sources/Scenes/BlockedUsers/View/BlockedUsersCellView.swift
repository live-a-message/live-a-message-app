//
//  BlokedUserCellViewModel.swift
//  Akee
//
//  Created by Vinicius Mesquita on 02/12/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem
import Networking

final class BlockedUsersCellView: UITableViewCell, TableViewCell {
    typealias ViewModel = BlockedUsersCellViewModel
    static var identifier: String = String(describing: type(of: self))
    let selectedBackgroundViewColor = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectedBackgroundViewColor.backgroundColor = AKColor.shadowRed

        self.textLabel?.textColor = AKColor.mainFontColor
        self.detailTextLabel?.textColor = AKColor.bodyFontColor
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(viewModel: BlockedUsersCellViewModel) {
        self.selectedBackgroundView = selectedBackgroundViewColor
        self.tintColor = AKColor.mainRed
        self.textLabel?.text = viewModel.title
        self.detailTextLabel?.text = viewModel.detail
    }
}

final class BlockedUsersCellViewModel: TableViewCellViewModel {
    var title: String
    var detail: String
    var user: User

    init(user: User) {
        self.user = user
        self.title = user.name
        self.detail = "@"+user.username
    }
}
