//
//  MessageDetailTableViewCell.swift
//  Akee
//
//  Created by Albert on 29/09/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import UIKit
import DesignSystem

class MessageDetailTableViewCell: UITableViewCell, ViewCode {
    
    lazy var titleLabel: AKLabel = {
        let label = AKLabel(style: AKLabelStyle.title2)
        label.textAlignment = .left
        return label
    }()

    lazy var messageLabel: AKLabel = {
        let label = AKLabel(style: AKLabelStyle.body1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    func fill(message: String) {
        configureViews()
        messageLabel.text = message
    }

    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(messageLabel)
    }

    func setupConstraints() {
        let corner = AKSpacing.medium.value
        let top = AKSpacing.xLarge.value
        titleLabel.top(to: self, offset: corner)
        titleLabel.left(to: self, offset: corner)
        titleLabel.right(to: self, offset: -corner)
        messageLabel.top(to: titleLabel, offset: top)
        messageLabel.left(to: self, offset: corner)
        messageLabel.right(to: self, offset: -corner)
        messageLabel.bottom(to: self, offset: -corner)
    }

    func configureViews() {
        buildHierarchy()
        setupConstraints()
    }

}
