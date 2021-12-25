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
    static var identifier: String = String(describing: type(of: CloseMessageTableViewCell.self))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(viewModel: BlockedUsersCellViewModel) {
        self.selectionStyle = .none
        self.tintColor = AKColor.mainRed
        self.imageView?.image = UIImage(systemName: IconNamed.envelope.rawValue)
        self.imageView?.layer.cornerRadius = 8
        self.imageView?.clipsToBounds = true
        self.textLabel?.text = viewModel.title
    }
}

final class BlockedUsersCellViewModel: TableViewCellViewModel {
    var title: String

    init(user: User) {
        self.title = user.name
    }
}
