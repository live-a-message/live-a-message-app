//
//  CloseMessageTableViewCell.swift
//  LiveAMessage
//
//  Created by Vinicius Mesquita on 13/09/21.
//  Copyright © 2021 LiveAMessage. All rights reserved.
//

import UIKit
import DesignSystem

class CloseMessageTableViewCell: UITableViewCell, TableViewCell {
    typealias ViewModel = CloseMessageCellViewModel
    static var identifier: String = String(describing: type(of: CloseMessageTableViewCell.self))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(viewModel: CloseMessageCellViewModel) {
        self.selectionStyle = .none
        self.tintColor = AKColor.mainRed
        self.imageView?.image = UIImage(systemName: IconNamed.envelope.rawValue)
        self.imageView?.layer.cornerRadius = 8
        self.imageView?.clipsToBounds = true
        self.textLabel?.text = viewModel.title
        self.detailTextLabel?.text = viewModel.message.content
    }
}
